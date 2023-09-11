// To parse this JSON data, do
//
//     final anasayfaFiltre = anasayfaFiltreFromJson(jsonString);

import 'dart:convert';

AnasayfaFiltre anasayfaFiltreFromJson(String str) => AnasayfaFiltre.fromJson(json.decode(str));

String anasayfaFiltreToJson(AnasayfaFiltre data) => json.encode(data.toJson());



class AnasayfaFiltre {
    List<int>? kitapid;
    List<int>? yayineviid;
    List<int>? ogrenciid;

    AnasayfaFiltre({
        this.kitapid,
        this.yayineviid,
        this.ogrenciid,
    });

    factory AnasayfaFiltre.fromJson(Map<String, dynamic> json) => AnasayfaFiltre(
        kitapid: json["Kitapid"] == null ? [] : List<int>.from(json["Kitapid"]!.map((x) => x)),
        yayineviid: json["Yayineviid"] == null ? [] : List<int>.from(json["Yayineviid"]!.map((x) => x)),
        ogrenciid: json["Ogrenciid"] == null ? [] : List<int>.from(json["Ogrenciid"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Kitapid": kitapid == null ? [] : List<dynamic>.from(kitapid!.map((x) => x)),
        "Yayineviid": yayineviid == null ? [] : List<dynamic>.from(yayineviid!.map((x) => x)),
        "Ogrenciid": ogrenciid == null ? [] : List<dynamic>.from(ogrenciid!.map((x) => x)),
    };
}
