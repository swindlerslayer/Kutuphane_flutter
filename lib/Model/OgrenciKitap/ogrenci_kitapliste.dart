// To parse this JSON data, do
//
//     final ogrenciKitapListe = ogrenciKitapListeFromJson(jsonString);

import 'dart:convert';

List<OgrenciKitapListe> ogrenciKitapListeFromJson(String str) => List<OgrenciKitapListe>.from(json.decode(str).map((x) => OgrenciKitapListe.fromJson(x)));

String ogrenciKitapListeToJson(List<OgrenciKitapListe> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OgrenciKitapListe {
    int? id;
    int? ogrenciId;
    int? kitapId;
    String? alisTarihi;
    dynamic teslimTarihi;
    dynamic kullancId;
    String? kayitTarihi;
    dynamic degisiklikYapan;
    String? degisiklikTarihi;
    bool? teslimDurumu;
    String? adiSoyadi;
    int? okulNo;
    String? adi;
    String? adi1;

    OgrenciKitapListe({
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
        this.adiSoyadi,
        this.okulNo,
        this.adi,
        this.adi1,
    });

    factory OgrenciKitapListe.fromJson(Map<String, dynamic> json) => OgrenciKitapListe(
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
        adiSoyadi: json["AdiSoyadi"],
        okulNo: json["OkulNo"],
        adi: json["Adi"],
        adi1: json["Adi1"],
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
        "AdiSoyadi": adiSoyadi,
        "OkulNo": okulNo,
        "Adi": adi,
        "Adi1": adi1,
    };
}
