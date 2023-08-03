class ApiEndPoints {
  static const String baseUrl = 'https://localhost:44399/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {

  
  final String registerEmail = 'api/kullanici/kullaniciKayit';
  final String loginEmail = 'api/kullanici/kullaniciKontrol';
}


