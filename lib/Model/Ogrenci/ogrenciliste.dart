
import 'dart:convert';

List<OgrenciList> ogrenciListFromJson(String str) => List<OgrenciList>.from(
    json.decode(str).map((x) => OgrenciList.fromJson(x)));

String ogrenciListToJson(List<OgrenciList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OgrenciList {
  int? id;
  String? adiSoyadi;
  int? okulNo;

  OgrenciList({
    this.id,
    this.adiSoyadi,
    this.okulNo,
  });

  factory OgrenciList.fromJson(Map<String, dynamic> json) => OgrenciList(
        id: json["ID"],
        adiSoyadi: json["AdiSoyadi"],
        okulNo: json["OkulNo"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AdiSoyadi": adiSoyadi,
        "OkulNo": okulNo,
      };
}
