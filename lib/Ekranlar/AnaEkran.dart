import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';
//

class NewScreen extends StatelessWidget {
  final kullanici;

  const NewScreen({super.key, required this.kullanici});

  @override
  Widget build(BuildContext context) {
    print(kullanici.kullaniciAdi);
    return MaterialApp(
      title: 'Ana Ekran',
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text('Ana Ekran'),
        ),
        body: const Center(
          child: Text('Giriş Başarılı'),
        ),
      ),
    );
  }
}
