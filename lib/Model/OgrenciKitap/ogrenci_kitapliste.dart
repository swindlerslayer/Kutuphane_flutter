import 'dart:convert';

List<OgrenciKitapListe> ogrenciKitapListeFromJson(String str) =>
    List<OgrenciKitapListe>.from(
        json.decode(str).map((x) => OgrenciKitapListe.fromJson(x)));

String ogrenciKitapListeToJson(List<OgrenciKitapListe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OgrenciKitapListe {
  int? id;
  String? adiSoyadi;
  int? okulNo;
  String? adi;
  String? yayinEviAdi;
  String? alisTarihi;
  String? teslimTarihi;
  bool? teslimDurumu;

  OgrenciKitapListe({
    this.id,
    this.adiSoyadi,
    this.okulNo,
    this.adi,
    this.yayinEviAdi,
    this.alisTarihi,
    this.teslimTarihi,
    this.teslimDurumu,
  });

  factory OgrenciKitapListe.fromJson(Map<String, dynamic> json) =>
      OgrenciKitapListe(
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
