import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class KitapTurSayfasi extends StatelessWidget {
  final loggedInUser;
  const KitapTurSayfasi({Key? key, required this.loggedInUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: loggedInUser),
      appBar: AppBar(
        title: const Text('Kitap Türü Sayfası'),
      ),
    );
  }
}
