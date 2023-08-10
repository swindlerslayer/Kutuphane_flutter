import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class KitapSayfasi extends StatelessWidget {
  final kullanici;

  const KitapSayfasi({Key? key, this.kullanici}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kitaplar = GetKitap(
        kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
    //Future<List<ListeKitap>?> kitaplar = GetKitap(
    //     kullanici.kullaniciAdi.toString(), kullanici.parola.toString());

    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Kitap Sayfası'),
      ),
      body: Column(
        //Bu kısma ListView Gelece

        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            //itemCount: kitaplar.length,
            prototypeItem: ListTile(
              title: Text(kullanici.toString()),
            ),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(/**/ kitaplar.toString()),
                ),
              );
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.book_online),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
