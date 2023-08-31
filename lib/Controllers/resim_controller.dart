import 'dart:convert';

import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Model/Resim/resimliste.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';
import 'package:http/http.dart' as http;

class ResimController extends GetxController {
  final _sayfaresimList = <ListeResim>[].obs;
  List<ListeResim>? get sayfaresimList => _sayfaresimList;
  set sayfaresimList(List<ListeResim>? value) => _sayfaresimList;

  Future<List<ListeResim>?> getResim(
      String kullaniciAdi, String parola, int id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/resimlisteyeekle?id=$id'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        List<ListeResim> resimler = listeResimFromJson(response.body);
        sayfaresimList?.addAll(resimler);
        return resimler;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  
  Future<String> topluResimEkle(
      String kullaniciAdi, String parola, List<ListeResim> k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/topluresimekle');

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
