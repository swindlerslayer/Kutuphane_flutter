

import 'dart:convert';

Kitap KitapFromJson(String str) => Kitap.fromJson(json.decode(str));

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
  dynamic degisiklikYapan;
  String? degisiklikTarihi;
  String? resim;
  dynamic kitapTuru;
  dynamic yayinEvi;
  dynamic yazar;
  List<dynamic>? kitapOgrenci;

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
    this.kitapTuru,
    this.yayinEvi,
    this.yazar,
    this.kitapOgrenci,
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
        kitapTuru: json["KitapTuru"],
        yayinEvi: json["YayinEvi"],
        yazar: json["Yazar"],
        kitapOgrenci: List<dynamic>.from(json["KitapOgrenci"].map((x) => x)),
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
        "KitapTuru": kitapTuru,
        "YayinEvi": yayinEvi,
        "Yazar": yazar,
        "KitapOgrenci": List<dynamic>.from(kitapOgrenci!.map((x) => x)),
      };
}
