import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class OgrenciSayfasi extends StatelessWidget {
  final kullanici;
  const OgrenciSayfasi({Key? key, required this.kullanici}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Ogrenci Sayfası'),
      ),
    );
  }
}
