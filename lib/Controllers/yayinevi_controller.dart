import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Degiskenler/yayinevi.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class YayineviController extends GetxController {
  final _yayineviliste = <YayineviListe>[].obs;
  List<YayineviListe> get yayineviliste => _yayineviliste;
  set yayineviliste(List<YayineviListe> value) => _yayineviliste.value = value;

  // ignore: non_constant_identifier_names
  Future<List<YayineviListe>?> getYayinevi(
      String kullaniciAdi, String parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yayinevilisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {

        List<YayineviListe> yayinevi = yayineviListeFromJson(response.body);
        return yayinevi;
      } else {

        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
