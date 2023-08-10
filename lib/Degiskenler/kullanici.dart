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
  int iD = 0;
  var kullaniciAdi = ''.obs;
  var parola = ''.obs;
  var kayitYapan = ''.obs;
  var kayitTarihi = ''.obs;
  var degisiklikYapan = ''.obs;
  var degisiklikTarihi = ''.obs;

  KullaniciGiris.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    kullaniciAdi.value = json['KullaniciAdi'];
    parola.value = json['Parola'];
    kayitYapan.value = json['KayitYapan'];
    kayitTarihi.value = json['KayitTarihi'];
    degisiklikYapan.value = json['DegisiklikYapan'];
    degisiklikTarihi.value = json['DegisiklikTarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ID'] = iD;
    data['KullaniciAdi'] = kullaniciAdi.value;
    data['Parola'] = parola.value;
    data['KayitYapan'] = kayitYapan.value;
    data['KayitTarihi'] = kayitTarihi.value;
    data['DegisiklikYapan'] = degisiklikYapan.value;
    data['DegisiklikTarihi'] = degisiklikTarihi.value;
    return data;
  }
}

// class Degiskenler {
//   class EntityFullKitap {
//     int? id;
//     String? adi;
//     int? sayfaSayisi;
//     int? kitapTurID;
//     int? yayinEviID;
//     int? yazarID;
//     int? barkod;
//     String? kayitYapan;
//     DateTime? kayitTarihi;
//     String? degisiklikYapan;
//     DateTime? degisiklikTarihi;
//     List<int>? resim; // Byte dizisi yerine bir tür liste kullanıldı

//     EntityFullKitap({
//       this.id,
//       this.adi,
//       this.sayfaSayisi,
//       this.kitapTurID,
//       this.yayinEviID,
//       this.yazarID,
//       this.barkod,
//       this.kayitYapan,
//       this.kayitTarihi,
//       this.degisiklikYapan,
//       this.degisiklikTarihi,
//       this.resim,
//     });
//   }
// }
