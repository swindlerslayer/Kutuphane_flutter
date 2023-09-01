// To parse this JSON data, do
//
//     final listeResim = listeResimFromJson(jsonString);

import 'dart:convert';

List<ListeResim> listeResimFromJson(String str) =>
    List<ListeResim>.from(json.decode(str).map((x) => ListeResim.fromJson(x)));

String listeResimToJson(List<ListeResim> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListeResim {
  int? id;
  dynamic resim1;
  int? kitapId;
  String? kayitYapan;
  DateTime? kayitTarihi;
  String? degisiklikYapan;
  DateTime? degisiklikTarihi;
  String? ebat;
  String? boyut;
  bool? secim = false;

  ListeResim(
      {this.id,
      this.resim1,
      this.kitapId,
      this.kayitYapan,
      this.kayitTarihi,
      this.degisiklikYapan,
      this.degisiklikTarihi,
      this.ebat,
      this.boyut,
      this.secim});

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
        secim: json["Secim"],
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
        "Secim": secim,
      };
}
