import 'dart:convert';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Controllers/Degiskenler/kullanici.dart';

class LoginController {
  static const String baseUrl = "https://localhost:44399/api";

// getfinal_   aşşağıdaki 3 satırlık get-set propertie'yi oluşturur.

  final _id = 0.obs;
  get id => _id.value;
  set id(value) => _id.value = value;

  Future<Kullanici?> loginUser(
      BuildContext context, String kullaniciAdi, String parola) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/kullanici/kullaniciBul?kullaniciAdi=$kullaniciAdi&parola=$parola'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        // API'den dönen cevabı JSON olarak çözüyoruz.
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Kullanıcı bilgilerini kullanarak Kullanici nesnesini oluşturuyoruz.
        Kullanici kullanici = Kullanici.fromJson(responseData);

        // Kullanıcıyı dönüyoruz.
        return kullanici;
      } else {
        // Giriş başarısız oldu, null değeri dönüyoruz.
        return null;
      }
    } catch (e) {
      // Hata oluştuğunda veya API'ye ulaşılamadığında null dönüyoruz.
      return null;
    }
  }
}
