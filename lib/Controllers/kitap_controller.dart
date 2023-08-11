import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Degiskenler/kitap.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class KitapController extends GetxController {
  final _kitapList = <ListeKitap>[].obs;
  List<ListeKitap> get kitapList => _kitapList;
  set kitapList(List<ListeKitap> value) => _kitapList.value = value;

  void get refResh {
    _kitapList.refresh();
  }

  // ignore: non_constant_identifier_names
  Future<List<ListeKitap>?> getKitap(String KullaniciAdi, String Parola) async {
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

  // ignore: non_constant_identifier_names
  Future<bool> silKitap(RxString KullaniciAdi, RxString Parola, int? ID) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: KullaniciAdi, parola: Parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitapsil?ID=$ID'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        print('Kitap Silme Başarılı ${response.statusCode}');

        return true;
      } else {
        print('Kitap Silme Başarısız ${response.statusCode}');

        return false;
      }
    } catch (e) {
      print('??? ?? $e  ');
      return false;
    }
  }

}
