import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Ekranlar/AnaEkran.dart';
import 'package:kutuphane_mobil_d/Ekranlar/kitapekran.dart';
import 'package:kutuphane_mobil_d/Ekranlar/kitapteslimekran.dart';
import 'package:kutuphane_mobil_d/Ekranlar/ogrenciekran.dart';

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
            onTap: () => {Get.to(KitapSayfasi(kullanici: kullanici))},
          ),
          ListTile(
            leading: const Icon(Icons.perm_contact_cal),
            title: const Text('Yazar'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.type_specimen),
            title: const Text('Kitap Türü'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.home_work),
            title: const Text('Yayınevi'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
