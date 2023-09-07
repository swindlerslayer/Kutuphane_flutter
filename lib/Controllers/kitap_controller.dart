import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil_d/Model/Filtre/filtre.dart';
import 'package:kutuphane_mobil_d/Model/Filtre/kitapfiltre.dart';
import 'package:kutuphane_mobil_d/Model/Kitap/kitap.dart';

import 'package:kutuphane_mobil_d/Model/Kitap/kitapliste.dart';
import 'package:kutuphane_mobil_d/Model/KitapTur/kitapturu.dart';
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/Model/PageCount/toplamsayfa.dart';
import 'package:kutuphane_mobil_d/Model/Yayinevi/yayinevi.dart';
import 'package:kutuphane_mobil_d/Model/Yazar/yazar.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

Future sleep2() {
  return Future.delayed(const Duration(seconds: 2), () => "2");
}

class KitapController extends GetxController {
  final _gelenpagecount = 0.obs;
  int? get gelenpagecount => _gelenpagecount.value;
  set gelenpagecount(int? value) => _gelenpagecount.value = value!;

  final _secilenkitap = 0.obs;
  int? get secilenkitap => _secilenkitap.value;
  set secilenkitap(int? value) => _secilenkitap.value = value!;

  final _filtreminsayfa = 0.obs;
  int? get filtreminsayfa => _filtreminsayfa.value;
  set filtreminsayfa(int? value) => _filtreminsayfa.value = value!;

  final _filtremaxsayfa = 0.obs;
  int? get filtremaxsayfa => _filtremaxsayfa.value;
  set filtremaxsayfa(int? value) => _filtremaxsayfa.value = value!;

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

  final _sayfakitapList = <ListeKitap>[].obs;
  List<ListeKitap>? get sayfakitapList => _sayfakitapList;
  set sayfakitapList(List<ListeKitap>? value) => _sayfakitapList;

  final _yazarlar = <Yazar>[].obs;
  List<Yazar>? get yazarlar => _yazarlar;
  set yazarlar(List<Yazar>? value) => _yazarlar;

  final _yayinevleri = <Yayinevi>[].obs;
  List<Yayinevi>? get yayinevleri => _yayinevleri;
  set yayinevleri(List<Yayinevi>? value) => _yayinevleri;

  final _kitapturleri = <KitapTur>[].obs;
  List<KitapTur>? get kitapturleri => _kitapturleri;
  set kitapturleri(List<KitapTur>? value) => _kitapturleri;

  final _kitapfiltre = KitapFiltre().obs;
  KitapFiltre get kitapfiltre => _kitapfiltre.value;
  set kitapfiltre(KitapFiltre value) => _kitapfiltre.value = value;

  final _filtre = GenelFiltre().obs;
  GenelFiltre get filtre => _filtre.value;
  set filtre(GenelFiltre value) => _filtre.value = value;

  final _filtrearama = "".obs;
  String? get filtrearama => _filtrearama.value;
  set filtrearama(String? value) => _filtrearama.value = value ?? '';

  void get refResh {
    _sayfakitapList.refresh();
  }

  void get clear {

  }

  Future<List<ListeKitap>?> getKitap(String kullaniciAdi, String parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitaplisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        List<ListeKitap> kitap = listeKitapFromJson(response.body);
        return kitap;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<ListeKitap>?> getSayfaFiltreKitap(MetodModel x) async {
    metodModelFromJson(jsonEncode(x));
    var ka = x.kullaniciAdi;
    var kp = x.parola;
    simdikisayfa = x.kalinanSayfa!;
    var ilk = x.lkSayfa;
    var apilink = ApiEndPoints.baseUrl;
    var filtre = x.filtre;

    filtrearama = x.querry;
    GenelFiltre xg = GenelFiltre();
    xg.kitapFiltre = filtre;
    xg.querry = filtrearama;
    xg.sayfa = simdikisayfa;

    xg.querry != null ? filtresayfa = true : filtresayfa = false;

    xg.kitapFiltre != null ? filtresayfa = true : filtresayfa = false;

    var token = await TokenService.getToken(
        kullaniciAdi: ka, parola: kp, loginMi: false);

    ilk == true ? simdikisayfa = 0 : simdikisayfa = simdikisayfa;

    if (ilk == true) {
      sayfakitapList?.clear();
      xg.sayfa = 0;
    }

    var client = http.Client();
    var url = Uri.parse('$apilink/api/kitapgetirfiltre');

    var headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token.accessToken}"
    };

    var badi = json.encode(xg);
    final response = await client.post(url, headers: headers, body: badi);

    if (response.statusCode == 200) {
      var dd = jsonDecode(response.body);
      List<ListeKitap> kitapListesi =
          listeKitapFromJson(jsonEncode(dd["Data"]));

      List<Toplamsayfa> totalpage =
          toplamSayfaaFromJson(jsonEncode(dd["toplamsayfa"]));
      simdikisayfa = int.parse(jsonEncode(dd["PageCount"]));

      gelenpagecount = totalpage[0].sayfaSayisi;
      totalPageCount = (gelenpagecount! / 15).ceil();

      _sayfakitapList.addAll(kitapListesi);
      isloading = false;
      return kitapListesi;
    } else {
      return null;
    }
  }

  Future<Kitap?> getTekKitap(
      String kullaniciAdi, String parola, int? iD) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitapgetir?ID=$iD'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        filtresayfa = false;
        Kitap kitap = KitapFromJson(response.body);
        return kitap;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> silKitap(RxString kullaniciAdi, RxString parola, int? iD) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);

    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitapsil?ID=$iD'),
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

  Future<String> ekleguncelleKitap(
      RxString kullaniciAdi, RxString parola, Kitap k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/ekleduzenle');

    try {
      var headers = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.accessToken}"
      };
      var badi = json.encode(k);
      final response = await client.post(url, headers: headers, body: badi);
      if (response.statusCode == 200) {
        return "Eklendi";
      } else if (response.statusCode == 500) {
        return k.id.toString();
      } else {
        return "?";
      }
    } catch (e) {
      return "?";
    }
  }
}
