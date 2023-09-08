import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/Model/PageCount/toplamsayfa.dart';
import 'package:kutuphane_mobil_d/Model/Yazar/yazarliste.dart';
import 'package:kutuphane_mobil_d/Model/Yazar/yazar.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class YazarController extends GetxController {
  final _yazarliste = <ListeYazar>[].obs;
  List<ListeYazar> get yazarliste => _yazarliste;
  set yazarliste(List<ListeYazar> value) => _yazarliste.value = value;

  final _secilenyazar = 0.obs;
  int? get secilenyazar => _secilenyazar.value;
  set secilenyazar(int? value) => _secilenyazar.value = value!;

  final _simdikisayfa = 0.obs;
  int? get simdikisayfa => _simdikisayfa.value;
  set simdikisayfa(int? value) => _simdikisayfa.value = value!;

  final _gelenyazar = Yazar().obs;
  Yazar get gelenyazar => _gelenyazar.value;
  set gelenyazar(Yazar value) => _gelenyazar.value = value;

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
    _yazarliste.refresh();
  }

  Future<List<ListeYazar>?> getSayfaFiltreYazar(MetodModel x) async {
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
      yazarliste.clear();
    }
    final response = await http.get(
      Uri.parse(
          '$apilink/api/yazarlisteyeekle?querry=$filtrearama&sayfa=$simdikisayfa'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer ${token.accessToken}"
      },
    );

    if (response.statusCode == 200) {
      var dd = jsonDecode(response.body);
      List<ListeYazar> kitapListesi =
          listeYazarFromJson(jsonEncode(dd["Data"]));

      List<Toplamsayfa> totalpage =
          toplamSayfaaFromJson(jsonEncode(dd["toplamsayfa"]));
      simdikisayfa = int.parse(jsonEncode(dd["PageCount"]));

      gelenpagecount = totalpage[0].sayfaSayisi;
      totalPageCount = (gelenpagecount! / 15).ceil();
      _yazarliste.addAll(kitapListesi);
      isloading = false;
      return kitapListesi;
    } else {
      return null;
    }
  }

  Future<List<ListeYazar>?> getYazar(String kullaniciAdi, String parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yazarlisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        List<ListeYazar> yazar = listeYazarFromJson(response.body);

        return yazar;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
//yazarsecimsifirla
 Future<bool> yazarSecimSifirla(String kullaniciAdi, String parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yazarsecimsifirla'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  Future<Yazar?> getTekYazar(
      String kullaniciAdi, String parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yazargetir?ID=$id'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        Yazar yazar = yazarFromJson(response.body);
        gelenyazar = yazar;
        return yazar;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> ekleguncelleYazar(
      String kullaniciAdi, String parola, Yazar k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/yazarekleduzenle');

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

  Future<bool> silYazar(RxString kullaniciAdi, RxString parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yazarsil?ID=$id'),
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
