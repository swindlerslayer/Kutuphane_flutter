import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/Kitap/kitap.dart';

import 'package:kutuphane_mobil_d/Model/Kitap/kitapliste.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

Future sleep2() {
  return Future.delayed(const Duration(seconds: 2), () => "2");
}

class KitapController extends GetxController {
  final _totalPageCount = 0.obs;
  int get totalPageCount => _totalPageCount.value;
  set totalPageCount(int value) => _totalPageCount.value = value;

  final _kitapList = <ListeKitap>[].obs;
  List<ListeKitap> get kitapList => _kitapList;
  set kitapList(List<ListeKitap> value) => _kitapList.value = value;

  final _sayfakitapList = <ListeKitap>[].obs;
  List<ListeKitap>? get sayfakitapList => _sayfakitapList;
  set sayfakitapList(List<ListeKitap>? value) => _sayfakitapList;

  void get refResh {
    _kitapList.refresh();
    _sayfakitapList.refresh();
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
        List<ListeKitap> kitap = listeKitapFromJson(response.body);
        return kitap;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<ListeKitap>?> getSayfaKitap(
      String kullaniciAdi, String parola, int sayfa) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitapgetirfiltre?id=$sayfa'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        var dd = jsonDecode(response.body);
        totalPageCount = dd["PageCount"];
        List<ListeKitap> kitapListesi =
            listeKitapFromJson(jsonEncode(dd["Data"]));
        _sayfakitapList.assignAll(kitapListesi);
        return listeKitapFromJson(jsonEncode(dd["Data"]));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Kitap?> getTekKitap(
      String kullaniciAdi, String parola, int? iD) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitapgetir?ID=$iD'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        Kitap kitap = KitapFromJson(response.body);
        return kitap;
      } else {
        return null;
      }
    } catch (e) {
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

      if (response.body.toString() == "true") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String> getByFilter(
      RxString kullaniciAdi, RxString parola, String k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/ekleduzenle');

    try {
      var headers = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.accessToken}"
      };
      var badi = json.encode(k);
      final response = await client.post(url, headers: headers, body: badi);
      if (response.body == "true") {
        return "Eklendi";
      } else {
        return "Güncellendi";
      }
    } catch (e) {
      return "?";
    }
  }

  Future<String> ekleguncelleKitap(
      RxString kullaniciAdi, RxString parola, Kitap k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/ekleduzenle');

    try {
      var headers = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.accessToken}"
      };
      var badi = json.encode(k);
      final response = await client.post(url, headers: headers, body: badi);
      if (response.body == "true") {
        return "Eklendi";
      } else {
        return "Güncellendi";
      }
    } catch (e) {
      return "?";
    }
  }
}
