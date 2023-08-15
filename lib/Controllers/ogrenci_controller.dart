import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/Ogrenci/ogrenci.dart';
import 'package:kutuphane_mobil_d/Model/Ogrenci/ogrenciliste.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class OgrenciController extends GetxController {
  final _ogrenciliste = <OgrenciList>[].obs;
  List<OgrenciList> get ogrenciliste => _ogrenciliste;
  set ogrenciliste(List<OgrenciList> value) => _ogrenciliste.value = value;

  // ignore: non_constant_identifier_names
  Future<List<OgrenciList>?> getOgrenci(
      String kullaniciAdi, String parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/ogrencilisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        List<OgrenciList> ogrenci = ogrenciListFromJson(response.body);
        return ogrenci;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Ogrenci?> getTekOgrenci(
      String kullaniciAdi, String parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/ogrencigetir?ID=$id'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        Ogrenci ogrenci = ogrenciFromJson(response.body);
        return ogrenci;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> ekleguncelleOgrenci(
      RxString kullaniciAdi, RxString parola, Ogrenci k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/ogrenciekleduzenle');

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

  Future<bool> silOgrenci(
      RxString kullaniciAdi, RxString parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/ogrencisil?ID=$id'),
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
}
