import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Controllers/Degiskenler/kitap.dart';
import 'dart:convert';
import 'package:kutuphane_mobil_d/URL/url.dart';

Future<Kitap?> GetKitap(String KullaniciAdi, String Parola) async {
  var apilink = ApiEndPoints.baseUrl;
  var token = await TokenService.getToken(
      kullaniciAdi: KullaniciAdi, parola: Parola, loginMi: false);
  try {
    // Get the token using await to wait for the response

    final response = await http.get(
      Uri.parse('$apilink/api/kitaplisteyeekle'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization":
            "Bearer ${token.accessToken}" // Use the actual token value
      },
    );

    if (response.statusCode == 200) {
      // API'den dönen cevabı JSON olarak çözüyoruz.
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Kitap bilgilerini kullanarak Kitap nesnesini oluşturuyoruz.
      Kitap kitap = Kitap.fromJson(responseData);

      // Kitap dönüyoruz.,
      print('Giriş başarılı ${response.statusCode}');

      return kitap;
    } else {
      // Giriş başarısız oldu, null değeri dönüyoruz.
      print('Giriş başarısız ${response.statusCode}   ');

      return null;
    }
  } catch (e) {
    // Hata oluştuğunda veya API'ye ulaşılamadığında null dönüyoruz.
    print('??? ?? $e  ');

    return null;
  }
}

// Future<Kitap?> GetKitap(String KullaniciAdi, String Parola) async {
//   var apilink = ApiEndPoints.baseUrl;

//   var token = TokenService.getToken(
//        kullaniciAdi: KullaniciAdi, parola: Parola, loginMi: false);



//   try {
//     final response = await http.get(
//       Uri.parse('$apilink/api/kitaplisteyeekle'),
//       headers: {
//         "Content-Type": "application/x-www-form-urlencoded",
//         "Authorization": "Bearer $token"
//       },
//     );

//     if (response.statusCode == 200) {
//       // API'den dönen cevabı JSON olarak çözüyoruz.
//       final Map<String, dynamic> responseData = json.decode(response.body);

//       // Kitap bilgilerini kullanarak Kitap nesnesini oluşturuyoruz.
//       Kitap kitap = Kitap.fromJson(responseData);

//       // Kitap dönüyoruz.,
//       print('Giriş başarılı ${response.statusCode}');

//       return kitap;
//     } else {
//       // Giriş başarısız oldu, null değeri dönüyoruz.
//       print('Giriş başarısız ${response.statusCode}   ');

//       return null;
//     }
//   } catch (e) {
//     // Hata oluştuğunda veya API'ye ulaşılamadığında null dönüyoruz.
//     print('??? ?? $e  ');

//     return null;
//   }
// }
