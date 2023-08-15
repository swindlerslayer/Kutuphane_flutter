import 'dart:convert';

// ignore: non_constant_identifier_names
Kitap KitapFromJson(String str) => Kitap.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String KitapToJson(Kitap data) => json.encode(data.toJson());

class Kitap {
  int? id;
  String? adi;
  int? sayfaSayisi;
  int? kitapTurId;
  int? yayinEviId;
  int? yazarId;
  int? barkod;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;
  String? resim;

  Kitap({
    this.id,
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
  });

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
      };
}
