import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Degiskenler/yazar.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class YazarController extends GetxController {
  final _yazarliste = <ListeYazar>[].obs;
  List<ListeYazar> get yazarliste => _yazarliste;
  set yazarliste(List<ListeYazar> value) => _yazarliste.value = value;

  // ignore: non_constant_identifier_names
  Future<List<ListeYazar>?> getYazar(String KullaniciAdi, String Parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: KullaniciAdi, parola: Parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yazarlisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        print('yazar Getirme Başarılı ${response.statusCode}');

        List<ListeYazar> yazar = listeYazarFromJson(response.body);
        return yazar;
      } else {
        print('Kitap Getirme Başarısız ${response.statusCode}');

        return null;
      }
    } catch (e) {
      print('??? ?? $e  ');
      return null;
    }
  }
}
