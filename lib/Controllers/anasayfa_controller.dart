import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/ogrenci_kitap.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class AnasayfaController extends GetxController {
  final _kitapogrenci = <OgrenciKitapListe>[].obs;
  List<OgrenciKitapListe> get kitapogrenci => _kitapogrenci;
  set kitapogrenci(List<OgrenciKitapListe> value) =>
      _kitapogrenci.value = value;

  Future<List<OgrenciKitapListe>?> getOgrenciKitap(
      String kullaniciAdi, String parOla) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parOla, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/ogrkitaplisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        List<OgrenciKitapListe> ogrenci =
            ogrenciKitapListeFromJson(response.body);
        return ogrenci;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
