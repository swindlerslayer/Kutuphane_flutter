import 'dart:convert';

import 'package:kutuphane_mobil_d/Model/Yazar/yazar.dart';

List<Yazar> drawerYazarListeFromJson(String str) => List<Yazar>.from(json.decode(str).map((x) => DrawerYazarListe.fromJson(x)));

String drawerYazarListeToJson(List<Yazar> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DrawerYazarListe {
    int? id;
    String? adiSoyadi;
    String? kayitYapan;
    String? kayitTarihi;
    dynamic degisiklikYapan;
    dynamic degisiklikTarihi;

    DrawerYazarListe({
        this.id,
        this.adiSoyadi,
        this.kayitYapan,
        this.kayitTarihi,
        this.degisiklikYapan,
        this.degisiklikTarihi,
    });

    factory DrawerYazarListe.fromJson(Map<String, dynamic> json) => DrawerYazarListe(
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
