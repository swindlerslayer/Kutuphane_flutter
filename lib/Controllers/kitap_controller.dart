import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Controllers/Degiskenler/kitap.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class kitapcontroller extends GetxController {
  final _kitapList = <ListeKitap>[].obs;
  List<ListeKitap> get kitapList => _kitapList;
  set kitapList(List<ListeKitap> value) => _kitapList.value = value;

  Future<List<ListeKitap>?> GetKitap(String KullaniciAdi, String Parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: KullaniciAdi, parola: Parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitaplisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        print('Kitap Getirme Başarılı ${response.statusCode}');

        List<ListeKitap> kitap = listeKitapFromJson(response.body);
        return kitap;
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
