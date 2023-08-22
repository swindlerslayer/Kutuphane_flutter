import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/anasayfa_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/kitapturu_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/ogrenci_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/yazar_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';

import 'package:kutuphane_mobil_d/screens/kitapteslimekran.dart';
import 'package:kutuphane_mobil_d/screens/kitapturuekran.dart';
import 'package:kutuphane_mobil_d/screens/ogrenciekran.dart';
import 'package:kutuphane_mobil_d/screens/yayineviekran.dart';
import 'package:kutuphane_mobil_d/screens/yazarekran.dart';

import 'AnaEkran.dart';
import 'kitapekran.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 62, 62, 62)
                //Resim eklenecekse decoration'un içerisine eklenecek
                ),
            child: Text(
              'Akdeniz Kütüphanesi ',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Anasayfa'),
            onTap: () async {
              var dd = await Get.put(AnasayfaController()).getOgrenciKitap(
                  kullanici.kullaniciAdi.toString(),
                  kullanici.parola.toString());
              Get.put(AnasayfaController()).kitapogrenci = dd ?? [];
              Get.back();
              Get.to(() => NewScreen(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Kitap Teslim'),
            onTap: () => {Get.to(KitapTeslimSayfasi(loggedInUser: kullanici))},
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: const Text('Öğrenci'),
            onTap: () async {
              var dd = await Get.put(OgrenciController()).getOgrenci(
                  kullanici.kullaniciAdi.toString(),
                  kullanici.parola.toString());
              Get.put(OgrenciController()).ogrenciliste = dd ?? [];
              Get.back();
              Get.to(() => OgrenciSayfasi(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Kitap'),
            onTap: () async {
              Get.back();
              final cont = Get.put(KitapController());
              cont.sayfakitapList?.clear();
              Get.to(() => KitapSayfasi(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.perm_contact_cal),
            title: const Text('Yazar'),
            onTap: () async {
              await Get.put(YazarController()).getYazar(
                  kullanici.kullaniciAdi.toString(),
                  kullanici.parola.toString());
              Get.back();
              Get.to(() => YazarSayfasi(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.type_specimen),
            title: const Text('Kitap Türü'),
            onTap: () async {
              var dd = await Get.put(KitapTurController()).getKitapTur(
                  kullanici.kullaniciAdi.toString(),
                  kullanici.parola.toString());
              Get.put(KitapTurController()).kitapturList = dd ?? [];
              Get.back();
              Get.to(() => KitapTurSayfasi(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.home_work),
            title: const Text('Yayınevi'),
            onTap: () async {
              var dd = await Get.put(YayineviController()).getYayinevi(
                  kullanici.kullaniciAdi.toString(),
                  kullanici.parola.toString());
              Get.put(YayineviController()).yayineviliste = dd ?? [];
              Get.back();
              Get.to(() => YayineviSayfasi(kullanici: kullanici));
            },
          ),
        ],
      ),
    );
  }
}
