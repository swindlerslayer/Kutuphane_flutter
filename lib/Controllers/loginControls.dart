import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static const String baseUrl = "https://localhost:44399/api";

  Future<bool> loginUser(
      BuildContext context, String kullaniciAdi, String parola) async {
    try {
      // API'ye login isteği gönderiyoruz.
      final response = await http.get(
        Uri.parse(
            '$baseUrl/kullanici/kullaniciBul?kullaniciAdi=$kullaniciAdi&parola=$parola'),
        headers: {
          "Authorization":
              "Bearer 45qPUaItaP7-Xp5jypspdYUe4pGpzOoIH9RGkiffKgVKXgPq6IO3CMbZKK_vS_lrdGl3L-5d9Bwh1WAdkd_VQfyEgIaWSDyFqg0FWjUSn4Y5uydKFNxgH3JqanCHyal2kTh7zjNqDNbBBLwa7SJKG_6bUpAmlWySYSBy6JuMdCWPwkvCr9M4sFOO_QDYRk8GsG6r6Vd6G-6QW9Ln0lNvf1ya5nroxvAvcnIWYkytaY4"
        },
      );

      // API'den başarılı bir şekilde cevap döndü mü kontrol ediyoruz.
      if (response.statusCode == 200) {
        // API'den dönen cevabı JSON olarak çözüyoruz.
        print('Giriş Başarılı');

        return true;
        // // Cevap true ise giriş başarılı oldu, true değeri dönüyoruz.
      } else {
        // Giriş başarısız oldu, false değeri dönüyoruz.
        return false;
      }
    } catch (e) {
      // Hata oluştuğunda veya API'ye ulaşılamadığında false dönüyoruz.
      return false;
    }
  }
}
