// To parse this JSON data, do
//
//     final kitapSayfa = kitapSayfaFromJson(jsonString);

import 'dart:convert';

List<KitapSayfa> kitapSayfaFromJson(String str) =>
    List<KitapSayfa>.from(json.decode(str).map((x) => KitapSayfa.fromJson(x)));

String kitapSayfaToJson(List<KitapSayfa> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KitapSayfa {
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

  KitapSayfa({
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

  factory KitapSayfa.fromJson(Map<String, dynamic> json) => KitapSayfa(
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
