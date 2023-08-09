import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Controllers/Degiskenler/kitap.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

// ignore: non_constant_identifier_names
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

      //İşlemin Başarı durumunu yazdırıyoruz
      print('Kitap Getirme Başarılı ${response.statusCode}');

      // Kitap dönüyoruz.,
      return listeKitapFromJson(response.body);
    } else {
      //İşlemin Başarı durumunu yazdırıyoruz
      print('Kitap Getirme Başarısız ${response.statusCode}');

      // Giriş başarısız oldu, null değeri dönüyoruz.
      return null;
    }
  } catch (e) {
    // Hata oluştuğunda veya API'ye ulaşılamadığında null dönüyoruz.
    print('??? ?? $e  ');

    return null;
  }
}
