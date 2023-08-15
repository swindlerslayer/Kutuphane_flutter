import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav_drawer.dart';

import '../Model/kullanici.dart';

class KitapTeslimSayfasi extends StatelessWidget {
  const KitapTeslimSayfasi({Key? key, required this.loggedInUser})
      : super(key: key);
  final KullaniciGiris loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: loggedInUser),
      appBar: AppBar(
        title: const Text('Kitap Teslim Sayfası'),
      ),
    );
  }
}
