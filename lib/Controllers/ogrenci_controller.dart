import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/Model/Ogrenci/ogrenci.dart';
import 'package:kutuphane_mobil_d/Model/Ogrenci/ogrenciliste.dart';
import 'package:kutuphane_mobil_d/Model/PageCount/toplamsayfa.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class OgrenciController extends GetxController {
  final _secilenogrenci = 0.obs;
  int? get secilenogrenci => _secilenogrenci.value;
  set secilenogrenci(int? value) => _secilenogrenci.value = value!;

  final _simdikisayfa = 0.obs;
  int? get simdikisayfa => _simdikisayfa.value;
  set simdikisayfa(int? value) => _simdikisayfa.value = value!;

  final _gelenogrenci = Ogrenci().obs;
  Ogrenci get gelenogrenci => _gelenogrenci.value;
  set gelenogrenci(Ogrenci value) => _gelenogrenci.value = value;

  final _filtrearama = "".obs;
  String? get filtrearama => _filtrearama.value;
  set filtrearama(String? value) => _filtrearama.value = value ?? '';

  final _filtresayfa = false.obs;
  bool get filtresayfa => _filtresayfa.value;
  set filtresayfa(bool value) => _filtresayfa.value = value;

  final _isloading = true.obs;
  bool get isloading => _isloading.value;
  set isloading(bool value) => _isloading.value = value;

  final _gelenpagecount = 0.obs;
  int? get gelenpagecount => _gelenpagecount.value;
  set gelenpagecount(int? value) => _gelenpagecount.value = value!;

  final _totalPageCount = 0.obs;
  int? get totalPageCount => _totalPageCount.value;
  set totalPageCount(int? value) => _totalPageCount.value = value!;

  void get refResh {
    _ogrenciliste.refresh();
  }

  final _ogrenciliste = <OgrenciList>[].obs;
  List<OgrenciList> get ogrenciliste => _ogrenciliste;
  set ogrenciliste(List<OgrenciList> value) => _ogrenciliste.value = value;

  Future<List<OgrenciList>?> getSayfaFiltreOgrenci(MetodModel x) async {
    metodModelFromJson(jsonEncode(x));
    var ka = x.kullaniciAdi;
    var kp = x.parola;
    simdikisayfa = x.kalinanSayfa!;
    var ilk = x.lkSayfa;
    var apilink = ApiEndPoints.baseUrl;

    filtrearama = x.querry;

    x.querry != null ? filtresayfa = true : filtresayfa = false;

    var token = await TokenService.getToken(
        kullaniciAdi: ka, parola: kp, loginMi: false);

    ilk == true ? simdikisayfa = 0 : simdikisayfa = simdikisayfa;

    if (ilk == true) {
      ogrenciliste.clear();
    }
    final response = await http.get(
      Uri.parse(
          '$apilink/api/ogrencilisteyeeklefiltre?querry=$filtrearama&sayfa=$simdikisayfa'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer ${token.accessToken}"
      },
    );

    if (response.statusCode == 200) {
      var dd = jsonDecode(response.body);
      List<OgrenciList> kitapListesi =
          ogrenciListFromJson(jsonEncode(dd["Data"]));

      List<Toplamsayfa> totalpage =
          toplamSayfaaFromJson(jsonEncode(dd["toplamsayfa"]));
      simdikisayfa = int.parse(jsonEncode(dd["PageCount"]));

      gelenpagecount = totalpage[0].sayfaSayisi;
      totalPageCount = (gelenpagecount! / 15).ceil();
      _ogrenciliste.addAll(kitapListesi);
      isloading = false;
      return kitapListesi;
    } else {
      return null;
    }
  }



  Future<Ogrenci?> getTekOgrenci(
      String kullaniciAdi, String parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/ogrencigetir?ID=$id'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        Ogrenci ogrenci = ogrenciFromJson(response.body);
        return ogrenci;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> ekleguncelleOgrenci(
      RxString kullaniciAdi, RxString parola, Ogrenci k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/ogrenciekleduzenle');

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

  Future<bool> silOgrenci(
      RxString kullaniciAdi, RxString parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/ogrencisil?ID=$id'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.body.toString() == "true") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
