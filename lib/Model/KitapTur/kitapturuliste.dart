
import 'dart:convert';

List<KitapTurListe> kitapTurListeFromJson(String str) =>
    List<KitapTurListe>.from(
        json.decode(str).map((x) => KitapTurListe.fromJson(x)));

String kitapTurListeToJson(List<KitapTurListe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KitapTurListe {
  int? id;
  String? adi;

  KitapTurListe({
    this.id,
    this.adi,
  });

  factory KitapTurListe.fromJson(Map<String, dynamic> json) => KitapTurListe(
        id: json["ID"],
        adi: json["Adi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": adi,
      };
}
