import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class KitapSayfasi extends StatelessWidget {
  KitapSayfasi({Key? key, this.kullanici}) : super(key: key);
  final cont = Get.put(KitapController());
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
        title: const Text('Kitap Sayfası'),
      ),
      body: Container(
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: cont.kitapList.length,
            itemBuilder: (context, index) {
              var data = cont.kitapList[index];
              return GestureDetector(
                onLongPress: () {
                  print('LONGPRES');
                },
                child: Card(
                  child: ListTile(
                    subtitle: Text(
                        'Yazarı :  ${data.yazarAdi ?? ""}                                              '),
                    leading: const Icon(
                      Icons.menu_book_rounded,
                    ),
                    title: Text(data.adi ?? ""),
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
