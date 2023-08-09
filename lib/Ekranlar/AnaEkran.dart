import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class NewScreen extends StatelessWidget {
  final kullanici;

  const NewScreen({Key? key, this.kullanici}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Kullanıcı Adı: ${kullanici?.kullaniciAdi}');

    return Scaffold(
        drawer: NavDrawer(kullanici: kullanici),
        appBar: AppBar(
          title: const Text('Ana Ekran'),
        ),
        body: ListView.builder(
          itemCount: 10,
          prototypeItem: ListTile(
            title: Text(kullanici.toString()),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(kullanici.kullaniciAdi.toString()),
            );
          },
        ));
  }
}
