// To parse this JSON data, do
//
//     final genelFiltre = genelFiltreFromJson(jsonString);

import 'dart:convert';

import 'package:kutuphane_mobil_d/Model/Filtre/kitapfiltre.dart';

GenelFiltre genelFiltreFromJson(String str) => GenelFiltre.fromJson(json.decode(str));

String genelFiltreToJson(GenelFiltre data) => json.encode(data.toJson());

class GenelFiltre {
    KitapFiltre? kitapFiltre;
    int? sayfa;
    String? querry;

    GenelFiltre({
        this.kitapFiltre,
        this.sayfa,
        this.querry,
    });

    factory GenelFiltre.fromJson(Map<String, dynamic> json) => GenelFiltre(
        kitapFiltre: json["KitapFiltre"] == null ? null : KitapFiltre.fromJson(json["KitapFiltre"]),
        sayfa: json["Sayfa"],
        querry: json["querry"],
    );

    Map<String, dynamic> toJson() => {
        "KitapFiltre": kitapFiltre?.toJson(),
        "Sayfa": sayfa,
        "querry": querry,
    };
}

