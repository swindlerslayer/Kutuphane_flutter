import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/denemedizayn.dart';
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
      width: 250,
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
              Get.back();
              Get.delete<KitapController>();

              Get.to(() => NewScreen(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Kitap Teslim'),
            onTap: () {
              Get.back();
              Get.delete<KitapController>();

              Get.to(KitapTeslimSayfasi(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: const Text('Öğrenci'),
            onTap: () async {
              Get.back();
              Get.delete<KitapController>();

              Get.to(() => OgrenciSayfasi(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Kitap'),
            onTap: () async {
              Get.back();

              Get.to(() => KitapSayfasi(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.perm_contact_cal),
            title: const Text('Yazar'),
            onTap: () async {
              Get.back();
              Get.delete<KitapController>();

              Get.to(() => YazarSayfasi(
                    kullanici: kullanici,
                    secim: 0,
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.type_specimen),
            title: const Text('Kitap Türü'),
            onTap: () async {
              Get.back();
              Get.delete<KitapController>();

              Get.to(() => KitapTurSayfasi(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.home_work),
            title: const Text('Yayınevi'),
            onTap: () async {
              Get.back();
              Get.delete<KitapController>();

              Get.to(() => YayineviSayfasi(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Deneme Sayfası '),
            onTap: () async {
              Get.back();
              Get.delete<KitapController>();

              Get.to(() => DenemeDizayn(kullanici: kullanici));
            },
          ),
        ],
      ),
    );
  }
}
