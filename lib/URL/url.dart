import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenClass {
  final String accessToken;
  final String tokenType;

  TokenClass({required this.accessToken, required this.tokenType});

  factory TokenClass.fromJson(Map<String, dynamic> json) {
    return TokenClass(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}

class TokenService {
  static const String uri = 'https://localhost:44399/';

  static Future<TokenClass> getToken({
    String grant_type = 'password',
    String kullaniciAdi = '',
    String parola = '',
    bool loginMi = false,
  }) async {
    var client = http.Client();
    http.Response response;
    try {
      var url = Uri.parse('${uri}token');
      var headers = <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      response = await client.post(url, headers: headers, body: {
        grant_type: 'password',
        kullaniciAdi: kullaniciAdi,
        parola: parola
      });
    } finally {
      client.close();
    }

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return TokenClass.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to get token.');
    }
  }
}

class ApiEndPoints {
  static const String baseUrl = 'https://localhost:44399/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'api/kullanici/kullaniciKayit';
  final String loginEmail = 'api/kullanici/kullaniciKontrol';
}
