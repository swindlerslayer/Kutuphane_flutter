/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
// ignore: camel_case_types
import 'package:get/get.dart';

class KullaniciController {
  // Burada kullanici, KullaniciGiris türünde olmalıdır.
  final _value = ''.obs;
  String get value => _value.value;
  set value(String value) => _value.value = value;
}

class KullaniciGiris {
  int? id;
  String? kullaniciAdi;
  String? parola;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;

  KullaniciGiris(
      {this.id,
      this.parola,
      this.kullaniciAdi,
      this.kayitYapan,
      this.kayitTarihi,
      this.degisiklikYapan,
      this.degisiklikTarihi});

  factory KullaniciGiris.fromJson(Map<String, dynamic> json) => KullaniciGiris(
        id: json['ID'],
        kullaniciAdi: json['KullaniciAdi'],
        parola: json['Parola'],
        kayitYapan: json['KayitYapan'],
        kayitTarihi: json['KayitTarihi'],
        degisiklikYapan: json['DegisiklikYapan'],
        degisiklikTarihi: json['DegisiklikTarihi'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ID'] = id;
    data['KullaniciAdi'] = kullaniciAdi;
    data['Parola'] = parola;
    data['KayitYapan'] = kayitYapan;
    data['KayitTarihi'] = kayitTarihi;
    data['DegisiklikYapan'] = degisiklikYapan;
    data['DegisiklikTarihi'] = degisiklikTarihi;
    return data;
  }
}
