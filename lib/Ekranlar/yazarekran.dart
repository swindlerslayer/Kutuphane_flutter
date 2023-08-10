import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/yazar_controller.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class YazarSayfasi extends StatelessWidget {
  YazarSayfasi({Key? key, this.kullanici}) : super(key: key);
  final cont = Get.put(YazarController());
  final kullanici;
  // var kitaplar = kitapcontroller.GetKitap(
  //     kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
  @override
  Widget build(BuildContext context) {
    PopupMenuButton(
      icon: const Icon(Icons.settings),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text("Düzenle"),
          onTap: () {},
        ),
        PopupMenuItem(
          child: const Text("Sil"),
          onTap: () {},
        ),
        PopupMenuItem(
          child: const Text("Google.com"),
          onTap: () {},
        ),
      ],
    );
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Yazar Sayfası'),
      ),
      body: Container(
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: cont.yazarliste.length,
            itemBuilder: (context, index) {
              var data = cont.yazarliste[index];
              return GestureDetector(
                onLongPress: () {
                  print('LONGPRES');
                },
                child: Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                    ),
                    title: Text(data.adiSoyadi ?? ""),
                    onTap: () {},
                  ), //listtile
                ), //card
              ); //guesturedetector
            },
          ),
        ),
      ),
    );
  }
}
