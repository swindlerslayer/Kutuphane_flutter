import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Ekranlar/AnaEkran.dart';
import 'package:kutuphane_mobil_d/Ekranlar/kitapekran.dart';
import 'package:kutuphane_mobil_d/Ekranlar/kitapteslimekran.dart';
import 'package:kutuphane_mobil_d/Ekranlar/kitapturuekran.dart';
import 'package:kutuphane_mobil_d/Ekranlar/ogrenciekran.dart';
import 'package:kutuphane_mobil_d/Ekranlar/yayineviekran.dart';
import 'package:kutuphane_mobil_d/Ekranlar/yazarekran.dart';

class NavDrawer extends StatelessWidget {
  final kullanici; // User information variable

  const NavDrawer({Key? key, required this.kullanici}) : super(key: key);

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
              'Menü',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Anasayfa'),
            onTap: () => {Get.to(NewScreen(kullanici: kullanici))},
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Kitap Teslim'),
            onTap: () => {Get.to(KitapTeslimSayfasi(loggedInUser: kullanici))},
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: const Text('Öğrenci'),
            onTap: () => {Get.to(OgrenciSayfasi(kullanici: kullanici))},
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Kitap'),
            onTap: () async {
              var dd = await Get.put(kitapcontroller()).GetKitap(
                  kullanici.kullaniciAdi.toString(),
                  kullanici.parola.toString());
              Get.put(kitapcontroller()).kitapList = dd ?? [];
              Get.back();

              Get.to(KitapSayfasi(kullanici: kullanici));
            },
          ),
          ListTile(
            leading: const Icon(Icons.perm_contact_cal),
            title: const Text('Yazar'),
            onTap: () => {Get.to(YazarSayfasi(loggedInUser: kullanici))},
          ),
          ListTile(
            leading: const Icon(Icons.type_specimen),
            title: const Text('Kitap Türü'),
            onTap: () => {Get.to(KitapTurSayfasi(loggedInUser: kullanici))},
          ),
          ListTile(
            leading: const Icon(Icons.home_work),
            title: const Text('Yayınevi'),
            onTap: () => {Get.to(YayineviSayfasi(loggedInUser: kullanici))},
          ),
        ],
      ),
    );
  }
}
