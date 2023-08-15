import 'dart:convert';

List<YayineviListe> yayineviListeFromJson(String str) =>
    List<YayineviListe>.from(
        json.decode(str).map((x) => YayineviListe.fromJson(x)));

String yayineviListeToJson(List<YayineviListe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YayineviListe {
  int? id;
  String? adi;

  YayineviListe({
    this.id,
    this.adi,
  });

  factory YayineviListe.fromJson(Map<String, dynamic> json) => YayineviListe(
        id: json["ID"],
        adi: json["Adi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": adi,
      };
}
