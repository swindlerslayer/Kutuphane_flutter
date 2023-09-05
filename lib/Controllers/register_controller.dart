import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';

import '../URL/url.dart';

class RegisterController extends GetxController {
  Future<String> register(KullaniciGiris x) async {
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/Register');

    try {
      var headers = <String, String>{"Content-Type": "application/json"};
      var badi = json.encode(x);
      final response = await client.post(url, headers: headers, body: badi);
      if (response.statusCode == 200) {
        return "Eklendi";
      } else if (response.statusCode == 500) {
        return x.id.toString();
      } else {
        return "?";
      }
    } catch (e) {
      return "?";
    }
  }
}
