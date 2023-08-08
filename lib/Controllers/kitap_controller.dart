import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Controllers/Degiskenler/kitap.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

Future<List<ListeKitap>?> GetKitap(String KullaniciAdi, String Parola) async {
  var apilink = ApiEndPoints.baseUrl;
  var token = await TokenService.getToken(
      kullaniciAdi: KullaniciAdi, parola: Parola, loginMi: false);
  try {
    final response = await http.get(
      Uri.parse('$apilink/api/kitaplisteyeekle'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization":
            "Bearer ${token.accessToken}" // Use the actual token value
      },
    );

    if (response.statusCode == 200) {
      // final Map<String, dynamic> responseData = json.decode(response.body);
      // Kitap bilgilerini kullanarak Kitap nesnesini oluşturuyoruz.

      // Kitap dönüyoruz.,
      print('Giriş başarılı ${response.statusCode}');

      return listeKitapFromJson(response.body);
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
