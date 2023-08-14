import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav_drawer.dart';

class KitapTeslimSayfasi extends StatelessWidget {
  final loggedInUser;
  const KitapTeslimSayfasi({Key? key, required this.loggedInUser})
      : super(key: key);

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
