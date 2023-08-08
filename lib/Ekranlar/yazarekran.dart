import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class YazarSayfasi extends StatelessWidget {
  final loggedInUser;
  const YazarSayfasi({Key? key, required this.loggedInUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: loggedInUser),
      appBar: AppBar(
        title: const Text('Yazar Sayfası'),
      ),
    );
  }
}
