// To parse this JSON data, do
//
//     final listeKitap = listeKitapFromJson(jsonString);

import 'dart:convert';

List<ListeKitap> listeKitapFromJson(String str) =>
    List<ListeKitap>.from(json.decode(str).map((x) => ListeKitap.fromJson(x)));

String listeKitapToJson(List<ListeKitap> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListeKitap {
  int? id;
  String? adi;
  int? sayfaSayisi;
  int? kitapTurId;
  int? yayinEviId;
  int? yazarId;
  String? barkod;
  String? kayitYapan;
  String? kayitTarihi;
  dynamic degisiklikYapan;
  String? degisiklikTarihi;
  dynamic resim;
  String? adiSoyadi;
  String? adi1;
  String? adi2;

  ListeKitap({
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
    this.adiSoyadi,
    this.adi1,
    this.adi2,
  });

  factory ListeKitap.fromJson(Map<String, dynamic> json) => ListeKitap(
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
        adiSoyadi: json["AdiSoyadi"],
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
        "AdiSoyadi": adiSoyadi,
        "Adi1": adi1,
        "Adi2": adi2,
      };
}
