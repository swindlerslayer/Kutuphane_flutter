/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
// ignore: camel_case_types
class yayinevi {
  int? iD;
  String? adi;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;

  yayinevi(
      {this.iD,
      this.adi,
      this.kayitYapan,
      this.kayitTarihi,
      this.degisiklikYapan,
      this.degisiklikTarihi});

  yayinevi.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    adi = json['Adi'];
    kayitYapan = json['KayitYapan'];
    kayitTarihi = json['KayitTarihi'];
    degisiklikYapan = json['DegisiklikYapan'];
    degisiklikTarihi = json['DegisiklikTarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Adi'] = adi;
    data['KayitYapan'] = kayitYapan;
    data['KayitTarihi'] = kayitTarihi;
    data['DegisiklikYapan'] = degisiklikYapan;
    data['DegisiklikTarihi'] = degisiklikTarihi;
    return data;
  }
}
