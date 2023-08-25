// To parse this JSON data, do
//
//     final metodModel = metodModelFromJson(jsonString);

import 'dart:convert';

MetodModel metodModelFromJson(String str) =>
    MetodModel.fromJson(json.decode(str));

String metodModelToJson(MetodModel data) => json.encode(data.toJson());

class MetodModel {
  String? kullaniciAdi;
  String? parola;
  String? islem;
  bool? lkSayfa;
  int? kalinanSayfa;
  String? querry;

  MetodModel({
    this.kullaniciAdi,
    this.parola,
    this.islem,
    this.lkSayfa,
    this.kalinanSayfa,
    this.querry
  });

  factory MetodModel.fromJson(Map<String, dynamic> json) => MetodModel(
        kullaniciAdi: json["KullaniciAdi"],
        parola: json["Parola"],
        islem: json["Islem"],
        lkSayfa: json["İlkSayfa"],
        kalinanSayfa: json["KalinanSayfa"],
        querry: json["Querry"]
      );

  Map<String, dynamic> toJson() => {
        "KullaniciAdi": kullaniciAdi,
        "Parola": parola,
        "Islem": islem,
        "İlkSayfa": lkSayfa,
        "KalinanSayfa": kalinanSayfa,
        "Querry":querry
      };
}
