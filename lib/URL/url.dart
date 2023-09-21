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
   Future<TokenClass> getToken({
    var kullaniciAdi = '',
    var parola = '',
    bool loginMi = false,
  }) async {
    try {
      var url = Uri.parse('${ApiEndPoints.baseUrl}token');
      var headers = <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var asd = await http.post(url, headers: headers, body: {
        'grant_type': 'password',
        'username': kullaniciAdi.toString(),
        'password': parola.toString()
      });
      if (asd.statusCode == 200) {
        var jsonResponse = json.decode(asd.body);
        return TokenClass.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to get token.');
      }
    } catch (e) {
      return TokenClass(accessToken: "", tokenType: "", expiresIn: 0);
    }
  }
}

class ApiEndPoints {
  static const String baseUrl = 'http://192.168.1.199:1199/';
}
