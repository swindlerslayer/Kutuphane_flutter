/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class Root {
  int? iD;
  String? adiSoyadi;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;

  Root(
      {this.iD,
      this.adiSoyadi,
      this.kayitYapan,
      this.kayitTarihi,
      this.degisiklikYapan,
      this.degisiklikTarihi});

  Root.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    adiSoyadi = json['AdiSoyadi'];
    kayitYapan = json['KayitYapan'];
    kayitTarihi = json['KayitTarihi'];
    degisiklikYapan = json['DegisiklikYapan'];
    degisiklikTarihi = json['DegisiklikTarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['AdiSoyadi'] = adiSoyadi;
    data['KayitYapan'] = kayitYapan;
    data['KayitTarihi'] = kayitTarihi;
    data['DegisiklikYapan'] = degisiklikYapan;
    data['DegisiklikTarihi'] = degisiklikTarihi;
    return data;
  }
}
