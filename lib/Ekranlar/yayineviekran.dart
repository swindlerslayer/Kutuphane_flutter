import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class YayineviSayfasi extends StatelessWidget {
  final loggedInUser;
  const YayineviSayfasi({Key? key, required this.loggedInUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: loggedInUser),
      appBar: AppBar(
        title: const Text('Yayinevi Sayfası'),
      ),
    );
  }
}