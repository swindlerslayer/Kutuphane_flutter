import 'dart:convert';

List<ListeKitap> listeKitapFromJson(String str) =>
    List<ListeKitap>.from(json.decode(str).map((x) => ListeKitap.fromJson(x)));

String listeKitapToJson(List<ListeKitap> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class KitapController {
//   // Burada Kitap, ListeKitap türünde olmalıdır.
//   final _value = ''.obs;
//   String get value => _value.value;
//   set value(String value) => _value.value = value;
// }

class ListeKitap {
  int? id;
  String? adi;
  String? yazarAdi;
  int? yazarId;
  String? resim;

  ListeKitap({
    this.id,
    this.adi,
    this.yazarAdi,
    this.yazarId,
    this.resim,
  });

  factory ListeKitap.fromJson(Map<String, dynamic> json) => ListeKitap(
        id: json["ID"],
        adi: json["Adi"],
        yazarAdi: json["YazarAdi"],
        yazarId: json["YazarID"],
        resim: json["Resim"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": adi,
        "YazarAdi": yazarAdi,
        "YazarID": yazarId,
        "Resim": resim,
      };
}
