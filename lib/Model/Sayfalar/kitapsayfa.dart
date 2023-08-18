// To parse this JSON data, do
//
//     final kitapSayfa = kitapSayfaFromJson(jsonString);

import 'dart:convert';

KitapSayfa kitapSayfaFromJson(String str) => KitapSayfa.fromJson(json.decode(str));

String kitapSayfaToJson(KitapSayfa data) => json.encode(data.toJson());

class KitapSayfa {
    List<Datum?>? data;
    int? pageCount;

    KitapSayfa({
        this.data,
        this.pageCount,
    });

    factory KitapSayfa.fromJson(Map<String, dynamic> json) => KitapSayfa(
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
        pageCount: json["PageCount"],
    );

    Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data!.map((x) => x?.toJson())),
        "PageCount": pageCount,
    };
}

class Datum {
    int? id;
    String? adi;
    int? sayfaSayisi;
    int? kitapTurId;
    int? yayinEviId;
    int? yazarId;
    int? barkod;
    String? kayitYapan;
    String? kayitTarihi;
    String? degisiklikYapan;
    String? degisiklikTarihi;
    String? resim;
    

    Datum({
        this.id,
        this.adi,
        this.sayfaSayisi,
        this.kitapTurId,
        this.yayinEviId,
        this.yazarId,
        this.barkod,
        this.kayitYapan,
        this.kayitTarihi,
        this.degisiklikYapan,
        this.degisiklikTarihi,
        this.resim,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        adi: json["Adi"],
        sayfaSayisi: json["SayfaSayisi"],
        kitapTurId: json["KitapTurID"],
        yayinEviId: json["YayinEviID"],
        yazarId: json["YazarID"],
        barkod: json["Barkod"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        resim: json["Resim"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": adi,
        "SayfaSayisi": sayfaSayisi,
        "KitapTurID": kitapTurId,
        "YayinEviID": yayinEviId,
        "YazarID": yazarId,
        "Barkod": barkod,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        "Resim": resim,
    };
}
