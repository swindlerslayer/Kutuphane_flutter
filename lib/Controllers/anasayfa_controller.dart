import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/Filtre/anasayfafiltre.dart';
import 'package:kutuphane_mobil_d/Model/Filtre/filtre.dart';
import 'package:kutuphane_mobil_d/Model/Kitap/kitap.dart';
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/Model/Ogrenci/ogrenci.dart';
import 'package:kutuphane_mobil_d/Model/OgrenciKitap/ogrenci_kitap.dart';
import 'package:kutuphane_mobil_d/Model/OgrenciKitap/ogrenci_kitapliste.dart';
import 'package:kutuphane_mobil_d/Model/PageCount/toplamsayfa.dart';
import 'package:kutuphane_mobil_d/Model/Yayinevi/yayinevi.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

// git init
// git add -A
// git commit -m "first commit"
// git branch -M main
// git remote add origin https://github.com/kharitonovAL/bot_medium.git
// git push -u origin main

class AnasayfaController extends GetxController {
  final _gelenpagecount = 0.obs;
  int? get gelenpagecount => _gelenpagecount.value;
  set gelenpagecount(int? value) => _gelenpagecount.value = value!;

  final _totalPageCount = 0.obs;
  int? get totalPageCount => _totalPageCount.value;
  set totalPageCount(int? value) => _totalPageCount.value = value!;

  final _isloading = true.obs;
  bool get isloading => _isloading.value;
  set isloading(bool value) => _isloading.value = value;

  final _filtresayfa = false.obs;
  bool get filtresayfa => _filtresayfa.value;
  set filtresayfa(bool value) => _filtresayfa.value = value;

  final _simdikisayfa = 0.obs;
  int get simdikisayfa => _simdikisayfa.value;
  set simdikisayfa(int value) => _simdikisayfa.value = value;

  final _sayfaogrencikitapList = <OgrenciKitapListe>[].obs;
  List<OgrenciKitapListe>? get sayfaogrencikitapList => _sayfaogrencikitapList;
  set sayfaogrencikitapList(List<OgrenciKitapListe>? value) =>
      _sayfaogrencikitapList;

  final _filtrearama = "".obs;
  String? get filtrearama => _filtrearama.value;
  set filtrearama(String? value) => _filtrearama.value = value ?? '';

  final _ogrenciler = <Ogrenci>[].obs;
  List<Ogrenci>? get ogrenciler => _ogrenciler;
  set ogrenciler(List<Ogrenci>? value) => _ogrenciler;

  final _kitaplar = <Kitap>[].obs;
  List<Kitap>? get kitaplar => _kitaplar;
  set kitaplar(List<Kitap>? value) => _kitaplar;

  final _yayinevleri = <Yayinevi>[].obs;
  List<Yayinevi>? get yayinevleri => _yayinevleri;
  set yayinevleri(List<Yayinevi>? value) => _yayinevleri;

  final _anasayfafiltre = AnasayfaFiltre().obs;
  AnasayfaFiltre get anasayfafiltre => _anasayfafiltre.value;
  set anasayfafiltre(AnasayfaFiltre value) => _anasayfafiltre.value = value;

  //   final _kitapfiltre = KitapFiltre().obs;
  // KitapFiltre get kitapfiltre => _kitapfiltre.value;
  // set kitapfiltre(KitapFiltre value) => _kitapfiltre.value = value;

  // final _kitapogrenci = <OgrenciKitapListe>[].obs;
  // List<OgrenciKitapListe> get kitapogrenci => _kitapogrenci;
  // set kitapogrenci(List<OgrenciKitapListe> value) =>
  //     _kitapogrenci.value = value;

  void refResh() {
    _sayfaogrencikitapList.refresh();
  }

  //False eskiden yeniye(id artan) // True yeniden eskiye(id azalan)
  //
  Future<List<OgrenciKitapListe>?> getSayfaFiltreOgrenciKitap(
      MetodModel x) async {
    metodModelFromJson(jsonEncode(x));
    var ka = x.kullaniciAdi;
    var kp = x.parola;
    simdikisayfa = x.kalinanSayfa!;
    var ilk = x.lkSayfa;
    var apilink = ApiEndPoints.baseUrl;
    var filtre = x.filtreanasayfa;

    filtrearama = x.querry;
    GenelFiltre xg = GenelFiltre();
    xg.anasayfaFiltre = filtre;
    xg.querry = filtrearama;
    xg.sayfa = simdikisayfa;

    x.querry != null ? filtresayfa = true : filtresayfa = false;

    var token = await TokenService.getToken(
        kullaniciAdi: ka, parola: kp, loginMi: false);

    ilk == true ? simdikisayfa = 0 : simdikisayfa = simdikisayfa;
    ilk == true ? xg.sayfa = 0 : xg.sayfa = simdikisayfa;

    if (ilk == true) {
      sayfaogrencikitapList?.clear();
    }
    var client = http.Client();

    var url = Uri.parse('$apilink/api/ogrencikitapgetirfiltre');

    var headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token.accessToken}"
    };

    var badi = json.encode(xg);
    final response = await client.post(url, headers: headers, body: badi);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var dd = jsonDecode(response.body);
      List<OgrenciKitapListe> kitapListesi =
          ogrenciKitapListeFromJson(jsonEncode(dd["Data"]));

      List<Toplamsayfa> totalpage =
          toplamSayfaaFromJson(jsonEncode(dd["toplamsayfa"]));
      simdikisayfa = int.parse(jsonEncode(dd["PageCount"]));

      gelenpagecount = totalpage[0].sayfaSayisi;
      totalPageCount = (gelenpagecount! / 15).ceil();

      _sayfaogrencikitapList.addAll(kitapListesi);

      isloading = false;
    } else {
      return null;
    }
    return null;
  }

  Future<OgrenciKitap?> getTekOgrenciKitap(
      String kullaniciAdi, String parola, int? iD) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/ogrencikitapteklisteyeekle?ID=$iD'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        OgrenciKitap kitap = ogrenciKitapFromJson(response.body);
        return kitap;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Future<List<OgrenciKitapListe>?> getOgrenciKitap(
  //     String kullaniciAdi, String parOla) async {
  //   var apilink = ApiEndPoints.baseUrl;
  //   var token = await TokenService.getToken(
  //       kullaniciAdi: kullaniciAdi, parola: parOla, loginMi: false);

  //   try {
  //     final response = await http.get(
  //       Uri.parse('$apilink/api/ogrkitaplisteyeekle'),
  //       headers: {
  //         "Content-Type": "application/x-www-form-urlencoded",
  //         "Authorization": "Bearer ${token.accessToken}"
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       List<OgrenciKitapListe> ogrenci =
  //           ogrenciKitapListeFromJson(response.body);
  //       return ogrenci;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future<String> ekleguncelleOgrenciKitap(
      RxString kullaniciAdi, RxString parola, OgrenciKitap k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/kitapogrenciekleduzenle');

    try {
      var headers = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.accessToken}"
      };
      var badi = json.encode(k);
      final response = await client.post(url, headers: headers, body: badi);
      if (response.body == "true") {
        return "Eklendi";
      } else {
        return "Güncellendi";
      }
    } catch (e) {
      return "?";
    }
  }
}
