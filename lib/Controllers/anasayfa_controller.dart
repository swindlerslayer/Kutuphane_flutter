import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/OgrenciKitap/ogrenci_kitap.dart';
import 'package:kutuphane_mobil_d/Model/OgrenciKitap/ogrenci_kitapliste.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class AnasayfaController extends GetxController {
  final _kitapogrenci = <OgrenciKitapListe>[].obs;
  List<OgrenciKitapListe> get kitapogrenci => _kitapogrenci;
  set kitapogrenci(List<OgrenciKitapListe> value) =>
      _kitapogrenci.value = value;

  Future<OgrenciKitap?> getTekOgrenciKitap(
      String kullaniciAdi, String parola, int? iD) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/ogrencikitapteklisteyeekle?ID=$iD'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        OgrenciKitap kitap = ogrenciKitapFromJson(response.body);
        return kitap;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

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

  Future<String> ekleguncelleOgrenciKitap(
      RxString kullaniciAdi, RxString parola, OgrenciKitap k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/kitapogrenciekleduzenle');

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
