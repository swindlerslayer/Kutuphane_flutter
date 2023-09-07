// To parse this JSON data, do
//
//     final kitapFiltre = kitapFiltreFromJson(jsonString);

import 'dart:convert';

KitapFiltre kitapFiltreFromJson(String str) => KitapFiltre.fromJson(json.decode(str));

String kitapFiltreToJson(KitapFiltre data) => json.encode(data.toJson());


class KitapFiltre {

    List<int>? yazarid;
    List<int>? yayineviid;
    List<int>? kitapturid;
    int? minsayfasayisi;
    int? maxsayfasayisi;

    KitapFiltre({
        this.yazarid,
        this.yayineviid,
        this.kitapturid,
        this.minsayfasayisi,
        this.maxsayfasayisi,
    });

    factory KitapFiltre.fromJson(Map<String, dynamic> json) => KitapFiltre(
        yazarid: json["Yazarid"] == null ? [] : List<int>.from(json["Yazarid"]!.map((x) => x)),
        yayineviid: json["Yayineviid"] == null ? [] : List<int>.from(json["Yayineviid"]!.map((x) => x)),
        kitapturid: json["Kitapturid"] == null ? [] : List<int>.from(json["Kitapturid"]!.map((x) => x)),
        minsayfasayisi: json["Minsayfasayisi"],
        maxsayfasayisi: json["Maxsayfasayisi"],
    );

    Map<String, dynamic> toJson() => {
        "Yazarid": yazarid == null ? [] : List<dynamic>.from(yazarid!.map((x) => x)),
        "Yayineviid": yayineviid == null ? [] : List<dynamic>.from(yayineviid!.map((x) => x)),
        "Kitapturid": kitapturid == null ? [] : List<dynamic>.from(kitapturid!.map((x) => x)),
        "Minsayfasayisi": minsayfasayisi,
        "Maxsayfasayisi": maxsayfasayisi,
    };
}
