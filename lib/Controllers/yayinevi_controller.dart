import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/PageCount/toplamsayfa.dart';
import 'package:kutuphane_mobil_d/Model/Yayinevi/yayinevi.dart';

import 'package:kutuphane_mobil_d/Model/Yayinevi/yayineviliste.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

import '../Model/MetodModel/metodmodel.dart';

class YayineviController extends GetxController {
  final _yayineviliste = <YayineviListe>[].obs;
  List<YayineviListe> get yayineviliste => _yayineviliste;
  set yayineviliste(List<YayineviListe> value) => _yayineviliste.value = value;

  final _secilenyayinevi = 0.obs;
  int? get secilenyayinevi => _secilenyayinevi.value;
  set secilenyayinevi(int? value) => _secilenyayinevi.value = value!;

  final _gelenyayinevi = Yayinevi().obs;
  Yayinevi get gelenyayinevi => _gelenyayinevi.value;
  set gelenyayinevi(Yayinevi value) => _gelenyayinevi.value = value;

  final _simdikisayfa = 0.obs;
  int? get simdikisayfa => _simdikisayfa.value;
  set simdikisayfa(int? value) => _simdikisayfa.value = value!;

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
    _yayineviliste.refresh();
  }

  Future<List<YayineviListe>?> getSayfaFiltreYayinevi(MetodModel x) async {
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
      yayineviliste.clear();
    }
    final response = await http.get(
      Uri.parse(
          '$apilink/api/yayinevilisteyeekle?query=$filtrearama&sayfa=$simdikisayfa'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer ${token.accessToken}"
      },
    );

    if (response.statusCode == 200) {
      var dd = jsonDecode(response.body);
      List<YayineviListe> kitapturliste =
          yayineviListeFromJson(jsonEncode(dd["Data"]));

      List<Toplamsayfa> totalpage =
          toplamSayfaaFromJson(jsonEncode(dd["toplamsayfa"]));
      simdikisayfa = int.parse(jsonEncode(dd["PageCount"]));

      gelenpagecount = totalpage[0].sayfaSayisi;
      totalPageCount = (gelenpagecount! / 15).ceil();

      _yayineviliste.addAll(kitapturliste);
      isloading = false;
      return kitapturliste;
    } else {
      return null;
    }
  }

  Future<Yayinevi?> getTekYayinevi(
      String kullaniciAdi, String parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yayinevigetir?ID=$id'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        Yayinevi yayinevi = yayineviFromJson(response.body);
        gelenyayinevi = yayinevi;
        return yayinevi;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> ekleguncelleYayinevi(
      RxString kullaniciAdi, RxString parola, Yayinevi k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/yayineviekleduzenle');

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

  Future<bool> silYayinevi(
      RxString kullaniciAdi, RxString parola, int? id) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/yayinevisil?ID=$id'),
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
