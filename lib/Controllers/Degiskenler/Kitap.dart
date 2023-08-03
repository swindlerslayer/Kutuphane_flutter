
class Root {
  int? iD;
  String? adi;
  int? sayfaSayisi;
  int? kitapTurID;
  int? yazarID;
  int? yayinEviID;
  int? barkod;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;

  Root(
      {this.iD,
      this.adi,
      this.sayfaSayisi,
      this.kitapTurID,
      this.yazarID,
      this.yayinEviID,
      this.barkod,
      this.kayitYapan,
      this.kayitTarihi,
      this.degisiklikYapan,
      this.degisiklikTarihi});

  Root.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    adi = json['adi'];
    sayfaSayisi = json['SayfaSayisi'];
    kitapTurID = json['KitapTurID'];
    yazarID = json['YazarID'];
    yayinEviID = json['YayinEviID'];
    barkod = json['Barkod'];
    kayitYapan = json['KayitYapan'];
    kayitTarihi = json['KayitTarihi'];
    degisiklikYapan = json['DegisiklikYapan'];
    degisiklikTarihi = json['DegisiklikTarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['adi'] = adi;
    data['SayfaSayisi'] = sayfaSayisi;
    data['KitapTurID'] = kitapTurID;
    data['YazarID'] = yazarID;
    data['YayinEviID'] = yayinEviID;
    data['Barkod'] = barkod;
    data['KayitYapan'] = kayitYapan;
    data['KayitTarihi'] = kayitTarihi;
    data['DegisiklikYapan'] = degisiklikYapan;
    data['DegisiklikTarihi'] = degisiklikTarihi;
    return data;
  }
}
