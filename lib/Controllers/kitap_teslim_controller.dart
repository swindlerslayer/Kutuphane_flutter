import 'dart:convert';

import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Model/OgrenciKitap/ogrenci_kitap.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';
import 'package:http/http.dart' as http;

class KitapTeslimController extends GetxController {
  final _secilenkitapid = 0.obs;
  int? get secilenkitapid => _secilenkitapid.value;
  set secilenkitapid(int? value) => _secilenkitapid.value = value!;

  final _secilenogrenciid = 0.obs;
  int? get secilenogrenciid => _secilenogrenciid.value;
  set secilenogrenciid(int? value) => _secilenogrenciid.value = value!;

  Future<String> ekleguncelleKitapTeslim(
      String kullaniciAdi, String parola, OgrenciKitap k) async {
    var tokencontrol = Get.put(TokenService());
    var token = await tokencontrol.getToken(
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
      if (response.statusCode == 200) {
        return "Eklendi";
      } else if (response.statusCode == 500) {
        return k.id.toString();
      } else {
        return "?";
      }
    } catch (e) {
      return "?";
    }
  }
}
//