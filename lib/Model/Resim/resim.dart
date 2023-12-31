import 'dart:convert';

Resim resimFromJson(String str) => Resim.fromJson(json.decode(str));

String resimToJson(Resim data) => json.encode(data.toJson());

class Resim {
  int? id;
  dynamic resim1;
  int? kitapId;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;
  String? ebat;
  String? boyut;

  Resim({
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

  factory Resim.fromJson(Map<String, dynamic> json) => Resim(
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
