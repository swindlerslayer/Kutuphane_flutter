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

  void _showContextMenu(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
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
                onLongPress: () async {
                  final RenderObject? overlay =
                      Overlay.of(context).context.findRenderObject();

                  await showMenu(
                      context: context,

                      // Show the context menu at the tap location
                      position: RelativeRect.fromRect(
                          const Rect.fromLTWH(30, 30, 30, 30),
                          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                              overlay.paintBounds.size.height)),

                      // set a list of choices for the context menu
                      items: [
                        const PopupMenuItem(
                          value: 'favorites',
                          child: Text('Add To Favorites'),
                        ),
                        const PopupMenuItem(
                          value: 'comment',
                          child: Text('Write Comment'),
                        ),
                      ]);
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
