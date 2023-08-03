import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Controllers/Degiskenler/Kullanici.dart';

class LoginController {
  static const String baseUrl = "https://localhost:44399/api";

  Future<Kullanici?> loginUser(BuildContext context, String kullaniciAdi,
      String parola, bool islogged) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/kullanici/kullaniciBul?kullaniciAdi=$kullaniciAdi&parola=$parola'),
        headers: {
          "Authorization":
              "Bearer 45qPUaItaP7-Xp5jypspdYUe4pGpzOoIH9RGkiffKgVKXgPq6IO3CMbZKK_vS_lrdGl3L-5d9Bwh1WAdkd_VQfyEgIaWSDyFqg0FWjUSn4Y5uydKFNxgH3JqanCHyal2kTh7zjNqDNbBBLwa7SJKG_6bUpAmlWySYSBy6JuMdCWPwkvCr9M4sFOO_QDYRk8GsG6r6Vd6G-6QW9Ln0lNvf1ya5nroxvAvcnIWYkytaY4"
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
