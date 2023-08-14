import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

TokenClass tokenFromJson(String str) => TokenClass.fromJson(json.decode(str));

String tokenToJson(TokenClass data) => json.encode(data.toJson());

class TokenClass {
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  TokenClass({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory TokenClass.fromJson(Map<String, dynamic> json) => TokenClass(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}

class TokenService {
  //static const String uri = 'https://localhost:44399/';

  static Future<TokenClass> getToken({
    var kullaniciAdi = '',
    var parola = '',
    bool loginMi = false,
  }) async {
    var client = http.Client();
    http.Response response;
    try {
      var url = Uri.parse('${ApiEndPoints.baseUrl}token');
      var headers = <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      response = await client.post(url, headers: headers, body: {
        'grant_type': 'password',
        'username': kullaniciAdi.toString(),
        'password': parola.toString()
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
}
