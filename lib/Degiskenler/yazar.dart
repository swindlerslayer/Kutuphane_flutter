/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
// To parse this JSON data, do
//
//     final listeYazar = listeYazarFromJson(jsonString);

import 'dart:convert';

List<ListeYazar> listeYazarFromJson(String str) =>
    List<ListeYazar>.from(json.decode(str).map((x) => ListeYazar.fromJson(x)));

String listeYazarToJson(List<ListeYazar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListeYazar {
  int? id;
  String? adiSoyadi;

  ListeYazar({
    this.id,
    this.adiSoyadi,
  });

  factory ListeYazar.fromJson(Map<String, dynamic> json) => ListeYazar(
        id: json["ID"],
        adiSoyadi: json["AdiSoyadi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AdiSoyadi": adiSoyadi,
      };
}

// To parse this JSON data, do
//
//     final yazar = yazarFromJson(jsonString);

Yazar yazarFromJson(String str) => Yazar.fromJson(json.decode(str));

String yazarToJson(Yazar data) => json.encode(data.toJson());

class Yazar {
  int? id;
  String? adiSoyadi;
  String? kayitYapan;
  String? kayitTarihi;
  dynamic degisiklikYapan;
  dynamic degisiklikTarihi;

  Yazar({
    this.id,
    this.adiSoyadi,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
  });

  factory Yazar.fromJson(Map<String, dynamic> json) => Yazar(
        id: json["ID"],
        adiSoyadi: json["AdiSoyadi"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AdiSoyadi": adiSoyadi,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
      };
}
