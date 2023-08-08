import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
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
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 16),
                  FloatingActionButton.small(
                    onPressed: () {
                      GetKitap(kullanici.kullaniciAdi, kullanici.parola);
                    },
                    child: const Icon(Icons.book_online),
                  ),
                ],
              ),
            ])));
  }
}
