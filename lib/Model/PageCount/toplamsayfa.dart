// To parse this JSON data, do
//
//     final toplamSayfaa = toplamSayfaaFromJson(jsonString);

import 'dart:convert';

// ToplamSayfaa toplamSayfaaFromJson(String str) =>
//     ToplamSayfaa.fromJson(json.decode(str));

List<Toplamsayfa> toplamSayfaaFromJson(String str) => List<Toplamsayfa>.from(
    json.decode(str).map((x) => Toplamsayfa.fromJson(x)));

String toplamSayfaaToJson(ToplamSayfaa data) => json.encode(data.toJson());

class ToplamSayfaa {
  List<Toplamsayfa>? toplamsayfa;

  ToplamSayfaa({
    this.toplamsayfa,
  });

  factory ToplamSayfaa.fromJson(Map<String, dynamic> json) => ToplamSayfaa(
        toplamsayfa: json["toplamsayfa"] == null
            ? []
            : List<Toplamsayfa>.from(
                json["toplamsayfa"]!.map((x) => Toplamsayfa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "toplamsayfa": toplamsayfa == null
            ? []
            : List<dynamic>.from(toplamsayfa!.map((x) => x.toJson())),
      };

  void addAll(List<ToplamSayfaa> totalpage) {}
}

class Toplamsayfa {
  int? sayfaSayisi;

  Toplamsayfa({
    this.sayfaSayisi,
  });

  factory Toplamsayfa.fromJson(Map<String, dynamic> json) => Toplamsayfa(
        sayfaSayisi: json["SayfaSayisi"],
      );

  Map<String, dynamic> toJson() => {
        "SayfaSayisi": sayfaSayisi,
      };
}
