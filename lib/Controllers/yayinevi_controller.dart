import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/Yayinevi/yayinevi.dart';

import 'package:kutuphane_mobil_d/Model/Yayinevi/yayineviliste.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class YayineviController extends GetxController {
  final _yayineviliste = <YayineviListe>[].obs;
  List<YayineviListe> get yayineviliste => _yayineviliste;
  set yayineviliste(List<YayineviListe> value) => _yayineviliste.value = value;

  // ignore: non_constant_identifier_names
  Future<List<YayineviListe>?> getYayinevi(
      String kullaniciAdi, String parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yayinevilisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        List<YayineviListe> yayinevi = yayineviListeFromJson(response.body);
        return yayinevi;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Yayinevi?> getTekYayinevi(
      String kullaniciAdi, String parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yayinevigetir?ID=$id'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        Yayinevi yayinevi = yayineviFromJson(response.body);
        return yayinevi;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> ekleguncelleYayinevi(
      RxString kullaniciAdi, RxString parola, Yayinevi k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/yayineviekleduzenle');

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

  Future<bool> silYayinevi(
      RxString kullaniciAdi, RxString parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yayinevisil?ID=$id'),
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
