// To parse this JSON data, do
//
//     final metodModel = metodModelFromJson(jsonString);

import 'dart:convert';

import 'package:kutuphane_mobil_d/Model/Filtre/anasayfafiltre.dart';
import 'package:kutuphane_mobil_d/Model/Filtre/kitapfiltre.dart';

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
  bool? artanazalan;
  KitapFiltre? filtrekitap;
  AnasayfaFiltre? filtreanasayfa;

  MetodModel(
      {this.kullaniciAdi,
      this.parola,
      this.islem,
      this.lkSayfa,
      this.kalinanSayfa,
      this.querry,
      this.artanazalan,
      this.filtrekitap,
      this.filtreanasayfa});

  factory MetodModel.fromJson(Map<String, dynamic> json) => MetodModel(
      kullaniciAdi: json["KullaniciAdi"],
      parola: json["Parola"],
      islem: json["Islem"],
      lkSayfa: json["İlkSayfa"],
      kalinanSayfa: json["KalinanSayfa"],
      querry: json["Querry"],
      artanazalan: json["ArtanAzalan"],
            filtrekitap: json["KitapFiltre"] == null ? null : KitapFiltre.fromJson(json["KitapFiltre"]),
      filtreanasayfa: json["AnasayfaFiltre"] == null ? null : AnasayfaFiltre.fromJson(json["AnasayfaFiltre"])
);
      

  Map<String, dynamic> toJson() => {
        "KullaniciAdi": kullaniciAdi,
        "Parola": parola,
        "Islem": islem,
        "İlkSayfa": lkSayfa,
        "KalinanSayfa": kalinanSayfa,
        "Querry": querry,
        "ArtanAzalan": artanazalan,
        "KitapFiltre": filtrekitap?.toJson(),
        "AnasayfaFiltre": filtreanasayfa?.toJson(),
      };
}
