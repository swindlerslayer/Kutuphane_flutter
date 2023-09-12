import 'dart:convert';

Kitap kitapFromJson(String str) => Kitap.fromJson(json.decode(str));

String kitapToJson(Kitap data) => json.encode(data.toJson());

class Kitap {
  int? id;
  String? adi;
  int? sayfaSayisi;
  int? kitapTurId;
  int? yayinEviId;
  int? yazarId;
  String? barkod;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;
  String? resim;
  String? adisoyadi;
  String? adi1;
  String? adi2;

  Kitap(
      {this.id,
      this.adi,
      this.sayfaSayisi,
      this.kitapTurId,
      this.yayinEviId,
      this.yazarId,
      this.barkod,
      this.kayitYapan,
      this.kayitTarihi,
      this.degisiklikYapan,
      this.degisiklikTarihi,
      this.resim,
      this.adisoyadi,
      this.adi1,
      this.adi2});

  factory Kitap.fromJson(Map<String, dynamic> json) => Kitap(
        id: json["ID"],
        adi: json["Adi"],
        sayfaSayisi: json["SayfaSayisi"],
        kitapTurId: json["KitapTurID"],
        yayinEviId: json["YayinEviID"],
        yazarId: json["YazarID"],
        barkod: json["Barkod"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        resim: json["Resim"],
        adisoyadi: json["AdiSoyadi"],
        adi1: json["Adi1"],
        adi2: json["Adi2"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": adi,
        "SayfaSayisi": sayfaSayisi,
        "KitapTurID": kitapTurId,
        "YayinEviID": yayinEviId,
        "YazarID": yazarId,
        "Barkod": barkod,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        "Resim": resim,
        "AdiSoyadi": adisoyadi,
        "Adi1": adi1,
        "Adi2": adi2,
      };
}
