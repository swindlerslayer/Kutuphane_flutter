import 'dart:convert';

OgrenciKitap ogrenciKitapFromJson(String str) =>
    OgrenciKitap.fromJson(json.decode(str));

String ogrenciKitapToJson(OgrenciKitap data) => json.encode(data.toJson());

class OgrenciKitap {
  int? id;
  String? adiSoyadi;
  int? okulNo;
  String? adi;
  String? yayinEviAdi;
  String? alisTarihi;
  String? teslimTarihi;
  bool? teslimDurumu;

  OgrenciKitap({
    this.id,
    this.adiSoyadi,
    this.okulNo,
    this.adi,
    this.yayinEviAdi,
    this.alisTarihi,
    this.teslimTarihi,
    this.teslimDurumu,
  });

  factory OgrenciKitap.fromJson(Map<String, dynamic> json) => OgrenciKitap(
        id: json["ID"],
        adiSoyadi: json["AdiSoyadi"],
        okulNo: json["OkulNo"],
        adi: json["Adi"],
        yayinEviAdi: json["YayinEviAdi"],
        alisTarihi: json["AlisTarihi"],
        teslimTarihi: json["TeslimTarihi"],
        teslimDurumu: json["TeslimDurumu"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AdiSoyadi": adiSoyadi,
        "OkulNo": okulNo,
        "Adi": adi,
        "YayinEviAdi": yayinEviAdi,
        "AlisTarihi": alisTarihi,
        "TeslimTarihi": teslimTarihi,
        "TeslimDurumu": teslimDurumu,
      };
}
