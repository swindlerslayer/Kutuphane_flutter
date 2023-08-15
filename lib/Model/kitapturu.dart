// To parse this JSON data, do
//
//     final kitapTurListe = kitapTurListeFromJson(jsonString);

import 'dart:convert';
// To parse this JSON data, do
//
//     final kitapTur = kitapTurFromJson(jsonString);

KitapTur kitapTurFromJson(String str) => KitapTur.fromJson(json.decode(str));

String kitapTurToJson(KitapTur data) => json.encode(data.toJson());

class KitapTur {
  int? id;
  String? adi;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;

  KitapTur({
    this.id,
    this.adi,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
  });

  factory KitapTur.fromJson(Map<String, dynamic> json) => KitapTur(
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

List<KitapTurListe> kitapTurListeFromJson(String str) =>
    List<KitapTurListe>.from(
        json.decode(str).map((x) => KitapTurListe.fromJson(x)));

String kitapTurListeToJson(List<KitapTurListe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KitapTurListe {
  int? id;
  String? adi;

  KitapTurListe({
    this.id,
    this.adi,
  });

  factory KitapTurListe.fromJson(Map<String, dynamic> json) => KitapTurListe(
        id: json["ID"],
        adi: json["Adi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": adi,
      };
}
