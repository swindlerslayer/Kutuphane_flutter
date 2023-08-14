import 'dart:convert';

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
        List<ListeYazar> yazar = listeYazarFromJson(response.body);
        return yazar;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Yazar?> getTekYazar(
      String kullaniciAdi, String parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yazargetir?ID=$id'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        Yazar yazar = yazarFromJson(response.body);
        return yazar;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> ekleguncelleYazar(
      RxString kullaniciAdi, RxString parola, Yazar k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/yazarekleduzenle');

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

  Future<bool> silYazar(RxString kullaniciAdi, RxString parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yazarsil?ID=$id'),
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
