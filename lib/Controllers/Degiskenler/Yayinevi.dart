/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class Root {
  int? iD;
  String? adi;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;

  Root(
      {this.iD,
      this.adi,
      this.kayitYapan,
      this.kayitTarihi,
      this.degisiklikYapan,
      this.degisiklikTarihi});

  Root.fromJson(Map<String, dynamic> json) {
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
