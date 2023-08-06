import 'package:flutter/material.dart';

import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class KitapSayfasi extends StatelessWidget {
  final kullanici;
  const KitapSayfasi({Key? key, required this.kullanici}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Kitap Sayfası'),
      ),
    );
  }
}
