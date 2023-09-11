// To parse this JSON data, do
//
//     final genelFiltre = genelFiltreFromJson(jsonString);

import 'dart:convert';

import 'package:kutuphane_mobil_d/Model/Filtre/anasayfafiltre.dart';
import 'package:kutuphane_mobil_d/Model/Filtre/kitapfiltre.dart';

GenelFiltre genelFiltreFromJson(String str) =>
    GenelFiltre.fromJson(json.decode(str));

String genelFiltreToJson(GenelFiltre data) => json.encode(data.toJson());

class GenelFiltre {
  AnasayfaFiltre? anasayfaFiltre;
  KitapFiltre? kitapFiltre;
  int? sayfa;
  String? querry;

  GenelFiltre({
    this.anasayfaFiltre,
    this.kitapFiltre,
    this.sayfa,
    this.querry,
  });

  factory GenelFiltre.fromJson(Map<String, dynamic> json) => GenelFiltre(
        anasayfaFiltre: json["AnasayfaFiltre"] == null
            ? null
            : AnasayfaFiltre.fromJson(json["AnasayfaFiltre"]),
        kitapFiltre: json["KitapFiltre"] == null
            ? null
            : KitapFiltre.fromJson(json["KitapFiltre"]),
        sayfa: json["Sayfa"],
        querry: json["querry"],
      );

  Map<String, dynamic> toJson() => {
        "AnasayfaFiltre": anasayfaFiltre?.toJson(),
        "KitapFiltre": kitapFiltre?.toJson(),
        "Sayfa": sayfa,
        "querry": querry,
      };
}
