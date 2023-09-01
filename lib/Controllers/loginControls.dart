import 'dart:convert';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  static const String baseUrl = "http://192.168.1.199/api";

// getfinal_   aşşağıdaki 3 satırlık get-set propertie'yi oluşturur.

  final _id = 0.obs;
  get id => _id.value;

  get sayfakitapList => null;
  set id(value) => _id.value = value;

  final _kullanicigiris = KullaniciGiris().obs;
  KullaniciGiris get kullanicigiris => _kullanicigiris.value;
  set kullanicigiris(KullaniciGiris value) => _kullanicigiris.value = value;

  Future<String> getUserCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? kullaniciadi = prefs.getString('kullaniciAdi');
    final String? kullaniciparola = prefs.getString('kullaniciAdi');
    return "$kullaniciadi + $kullaniciparola";
  }

  Future<KullaniciGiris?> loginUser(
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
        var gelenkullaniciadlari = await getUserCredentials();
        print(gelenkullaniciadlari);

        final Map<String, dynamic> responseData = json.decode(response.body);
        KullaniciGiris? kullanici = KullaniciGiris?.fromJson(responseData);
        kullanici.parola = parola;
        KullaniciController controller = KullaniciController();
        controller.value = kullanici.toString();
        Get.put(LoginController()).kullanicigiris = kullanici;

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('kullaniciAdi', kullanici.kullaniciAdi!);
        await prefs.setString('parola', kullanici.parola!);

        return kullanici;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
