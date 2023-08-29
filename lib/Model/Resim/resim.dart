import 'dart:convert';

Resim resimFromJson(String str) => Resim.fromJson(json.decode(str));

String resimToJson(Resim data) => json.encode(data.toJson());

class Resim {
  int? id;
  String? resim1;
  String? kitapId;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;

  Resim({
    this.id,
    this.resim1,
    this.kitapId,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
  });

  factory Resim.fromJson(Map<String, dynamic> json) => Resim(
        id: json["ID"],
        resim1: json["Resim1"],
        kitapId: json["KitapID"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Resim1": resim1,
        "KitapID": kitapId,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
      };
}
