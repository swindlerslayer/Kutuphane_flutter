// To parse this JSON data, do
//
//     final yayinevi = yayineviFromJson(jsonString);

import 'dart:convert';

Yayinevi yayineviFromJson(String str) => Yayinevi.fromJson(json.decode(str));

String yayineviToJson(Yayinevi data) => json.encode(data.toJson());

class Yayinevi {
  int? id;
  String? adi;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;

  Yayinevi({
    this.id,
    this.adi,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
  });

  factory Yayinevi.fromJson(Map<String, dynamic> json) => Yayinevi(
        id: json["ID"],
        adi: json["Adi"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": adi,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
      };
}

// To parse this JSON data, do
//
//     final yayineviListe = yayineviListeFromJson(jsonString);

List<YayineviListe> yayineviListeFromJson(String str) =>
    List<YayineviListe>.from(
        json.decode(str).map((x) => YayineviListe.fromJson(x)));

String yayineviListeToJson(List<YayineviListe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YayineviListe {
  int? id;
  String? adi;

  YayineviListe({
    this.id,
    this.adi,
  });

  factory YayineviListe.fromJson(Map<String, dynamic> json) => YayineviListe(
        id: json["ID"],
        adi: json["Adi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": adi,
      };
}
