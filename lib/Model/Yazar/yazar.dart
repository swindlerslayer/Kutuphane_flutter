import 'dart:convert';

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
