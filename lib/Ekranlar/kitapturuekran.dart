import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitapturu_controller.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';
import 'package:kutuphane_mobil_d/Ekranlar/popup.dart';

class KitapTurSayfasi extends StatelessWidget {
  KitapTurSayfasi({Key? key, this.kullanici}) : super(key: key);
  final cont = Get.put(KitapTurController());
  final kullanici;
  // var kitaplar = kitapcontroller.GetKitap(
  //     kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
  @override
  Widget build(BuildContext context) {
    PopupMenuButton(
      icon: const Icon(Icons.menu),
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
        title: const Text('Kitap Türü Sayfası'),
      ),
      body: Container(
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: cont.kitapturList.length,
            itemBuilder: (context, index) {
              var data = cont.kitapturList[index];
              return GestureDetector(
                onLongPress: () async {
                  showContextMenu(context);
                },
                child: Card(
                  child: ListTile(
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
