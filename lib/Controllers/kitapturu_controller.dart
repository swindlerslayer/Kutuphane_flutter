import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/KitapTur/kitapturu.dart';
import 'package:kutuphane_mobil_d/Model/KitapTur/kitapturuliste.dart';

import 'package:kutuphane_mobil_d/URL/url.dart';

class KitapTurController extends GetxController {
  final _kitapturList = <KitapTurListe>[].obs;
  List<KitapTurListe> get kitapturList => _kitapturList;
  set kitapturList(List<KitapTurListe> value) => _kitapturList.value = value;

  final _secilenkitaptur = 0.obs;
  int? get secilenkitaptur => _secilenkitaptur.value;
  set secilenkitaptur(int? value) => _secilenkitaptur.value = value!;

  final _gelenkitaptur = KitapTur().obs;
  KitapTur get gelenkitaptur => _gelenkitaptur.value;
  set gelenkitaptur(KitapTur value) => _gelenkitaptur.value = value;

  Future<List<KitapTurListe>?> getKitapTur(
    String kullaniciAdi,
    String parola,
  ) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitapturulisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        List<KitapTurListe> kitaptur = kitapTurListeFromJson(response.body);
        return kitaptur;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<KitapTur?> getTekKitapTur(
      String kullaniciAdi, String parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitapturugetir?ID=$id'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        KitapTur kitaptur = kitapTurFromJson(response.body);
        gelenkitaptur = kitaptur;
        return kitaptur;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> ekleguncelleKitapTur(
      RxString kullaniciAdi, RxString parola, KitapTur k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/kitapturuekleduzenle');

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

  Future<bool> silKitapTuru(
      RxString kullaniciAdi, RxString parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitapturusil?ID=$id'),
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
