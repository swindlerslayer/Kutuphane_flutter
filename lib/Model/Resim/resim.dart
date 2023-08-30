// To parse this JSON data, do
//
//     final listeResim = listeResimFromJson(jsonString);

import 'dart:convert';

ListeResim listeResimFromJson(String str) =>
    ListeResim.fromJson(json.decode(str));

String listeResimToJson(ListeResim data) => json.encode(data.toJson());

class ListeResim {
  int? id;
  dynamic resim1;
  int? kitapId;
  dynamic kayitYapan;
  dynamic kayitTarihi;
  dynamic degisiklikYapan;
  dynamic degisiklikTarihi;
  String? ebat;
  String? boyut;

  ListeResim({
    this.id,
    this.resim1,
    this.kitapId,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
    this.ebat,
    this.boyut,
  });

  factory ListeResim.fromJson(Map<String, dynamic> json) => ListeResim(
        id: json["ID"],
        resim1: json["Resim1"],
        kitapId: json["KitapID"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        ebat: json["Ebat"],
        boyut: json["Boyut"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Resim1": resim1,
        "KitapID": kitapId,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        "Ebat": ebat,
        "Boyut": boyut,
      };
}
