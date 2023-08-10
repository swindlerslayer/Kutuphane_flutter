import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Degiskenler/Ogrenci.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class OgrenciController extends GetxController {
  final _ogrenciliste = <OgrenciList>[].obs;
  List<OgrenciList> get ogrenciliste => _ogrenciliste;
  set ogrenciliste(List<OgrenciList> value) => _ogrenciliste.value = value;

  // ignore: non_constant_identifier_names
  Future<List<OgrenciList>?> getOgrenci(
      String KullaniciAdi, String Parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: KullaniciAdi, parola: Parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/ogrencilisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        print('Ogrenci Getirme Başarılı ${response.statusCode}');

        List<OgrenciList> ogrenci = ogrenciListFromJson(response.body);
        return ogrenci;
      } else {
        print('Ogrenci Getirme Başarısız ${response.statusCode}');

        return null;
      }
    } catch (e) {
      print('??? ?? $e  ');
      return null;
    }
  }
}
