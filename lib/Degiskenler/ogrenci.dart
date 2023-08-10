// To parse this JSON data, do
//
//     final ogrenci = ogrenciFromJson(jsonString);

import 'dart:convert';

Ogrenci ogrenciFromJson(String str) => Ogrenci.fromJson(json.decode(str));

String ogrenciToJson(Ogrenci data) => json.encode(data.toJson());

class Ogrenci {
  int? id;
  String? adiSoyadi;
  int? okulNo;
  String? kayitTarihi;
  String? kayitYapan;
  String? degisiklikTarihi;
  String? degisiklikYapan;

  Ogrenci({
    this.id,
    this.adiSoyadi,
    this.okulNo,
    this.kayitTarihi,
    this.kayitYapan,
    this.degisiklikTarihi,
    this.degisiklikYapan,
  });

  factory Ogrenci.fromJson(Map<String, dynamic> json) => Ogrenci(
        id: json["ID"],
        adiSoyadi: json["AdiSoyadi"],
        okulNo: json["OkulNo"],
        kayitTarihi: json["KayitTarihi"],
        kayitYapan: json["KayitYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AdiSoyadi": adiSoyadi,
        "OkulNo": okulNo,
        "KayitTarihi": kayitTarihi,
        "KayitYapan": kayitYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        "DegisiklikYapan": degisiklikYapan,
      };
}
// To parse this JSON data, do
//
//     final ogrenciList = ogrenciListFromJson(jsonString);

List<OgrenciList> ogrenciListFromJson(String str) => List<OgrenciList>.from(
    json.decode(str).map((x) => OgrenciList.fromJson(x)));

String ogrenciListToJson(List<OgrenciList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OgrenciList {
  int? id;
  String? adiSoyadi;
  int? okulNo;

  OgrenciList({
    this.id,
    this.adiSoyadi,
    this.okulNo,
  });

  factory OgrenciList.fromJson(Map<String, dynamic> json) => OgrenciList(
        id: json["ID"],
        adiSoyadi: json["AdiSoyadi"],
        okulNo: json["OkulNo"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AdiSoyadi": adiSoyadi,
        "OkulNo": okulNo,
      };
}
