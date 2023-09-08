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
  bool? secim;

  Yazar({
    this.id,
    this.adiSoyadi,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
    this.secim,
  });

  factory Yazar.fromJson(Map<String, dynamic> json) => Yazar(
        id: json["ID"],
        adiSoyadi: json["AdiSoyadi"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        secim: json["Secim"],


      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AdiSoyadi": adiSoyadi,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        "Secim": secim,
      };
}
