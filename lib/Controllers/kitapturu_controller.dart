import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Degiskenler/kitapturu.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class KitapTurController extends GetxController {
  final _kitapturList = <KitapTurListe>[].obs;
  List<KitapTurListe> get kitapturList => _kitapturList;
  set kitapturList(List<KitapTurListe> value) => _kitapturList.value = value;

  // ignore: non_constant_identifier_names
  Future<List<KitapTurListe>?> getKitapTur(
      String KullaniciAdi, String Parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: KullaniciAdi, parola: Parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitapturulisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        print('Kitap Türü Getirme Başarılı ${response.statusCode}');

        List<KitapTurListe> kitaptur = kitapTurListeFromJson(response.body);
        return kitaptur;
      } else {
        print('Kitap Tur Getirme Başarısız ${response.statusCode}');

        return null;
      }
    } catch (e) {
      print('??? ?? $e  ');
      return null;
    }
  }
}
