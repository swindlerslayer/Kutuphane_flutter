// To parse this JSON data, do
//
//     final ogrenciKitap = ogrenciKitapFromJson(jsonString);

import 'dart:convert';

OgrenciKitap ogrenciKitapFromJson(String str) =>
    OgrenciKitap.fromJson(json.decode(str));

String ogrenciKitapToJson(OgrenciKitap data) => json.encode(data.toJson());

class OgrenciKitap {
  int? id;
  int? ogrenciId;
  int? kitapId;
  String? alisTarihi;
  String? teslimTarihi;
  int? kullancId;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;
  bool? teslimDurumu;

  OgrenciKitap({
    this.id,
    this.ogrenciId,
    this.kitapId,
    this.alisTarihi,
    this.teslimTarihi,
    this.kullancId,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
    this.teslimDurumu,
  });

  factory OgrenciKitap.fromJson(Map<String, dynamic> json) => OgrenciKitap(
        id: json["ID"],
        ogrenciId: json["OgrenciID"],
        kitapId: json["KitapID"],
        alisTarihi: json["AlisTarihi"],
        teslimTarihi: json["TeslimTarihi"],
        kullancId: json["KullanıcıID"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        teslimDurumu: json["TeslimDurumu"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "OgrenciID": ogrenciId,
        "KitapID": kitapId,
        "AlisTarihi": alisTarihi,
        "TeslimTarihi": teslimTarihi,
        "KullanıcıID": kullancId,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        "TeslimDurumu": teslimDurumu,
      };
}
