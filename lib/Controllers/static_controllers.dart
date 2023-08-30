import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/anasayfa_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/kitapturu_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/ogrenci_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/yazar_controller.dart';

class Statikler {
  


  static listetemizle() {
    final cont = Get.put(KitapController());
    final contyazar = Get.put(YazarController());
    final contyayinevi = Get.put(YayineviController());
    final contogrenci = Get.put(OgrenciController());
    final contkitaptur = Get.put(KitapTurController());
    final contanasayfa = Get.put(AnasayfaController());

    cont.sayfakitapList?.clear();
    contyazar.yazarliste.clear();
    contyayinevi.yayineviliste.clear();
    contogrenci.ogrenciliste.clear();
    contkitaptur.kitapturList.clear();
    contanasayfa.kitapogrenci.clear();
  }
}
