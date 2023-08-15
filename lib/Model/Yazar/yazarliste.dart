import 'dart:convert';

List<ListeYazar> listeYazarFromJson(String str) =>
    List<ListeYazar>.from(json.decode(str).map((x) => ListeYazar.fromJson(x)));

String listeYazarToJson(List<ListeYazar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListeYazar {
  int? id;
  String? adiSoyadi;

  ListeYazar({
    this.id,
    this.adiSoyadi,
  });

  factory ListeYazar.fromJson(Map<String, dynamic> json) => ListeYazar(
        id: json["ID"],
        adiSoyadi: json["AdiSoyadi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AdiSoyadi": adiSoyadi,
      };
}
