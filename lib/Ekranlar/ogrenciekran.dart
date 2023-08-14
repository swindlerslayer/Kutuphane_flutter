import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/ogrenci_controller.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class OgrenciSayfasi extends StatelessWidget {
  OgrenciSayfasi({Key? key, this.kullanici}) : super(key: key);
  final cont = Get.put(OgrenciController());
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
        title: const Text('Ogrenci Sayfası'),
      ),
      body: Container(
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: cont.ogrenciliste.length,
            itemBuilder: (context, index) {
              var data = cont.ogrenciliste[index];
              return FocusedMenuHolder(
                menuItems: [
                  FocusedMenuItem(
                      backgroundColor: const Color.fromARGB(255, 109, 107, 107),
                      title: const Text("Düzenle"),
                      trailingIcon: const Icon(Icons.edit),
                      onPressed: () {}),
                  FocusedMenuItem(
                    backgroundColor: const Color.fromARGB(255, 110, 77, 77),
                    title: const Text("Sil"),
                    trailingIcon: const Icon(Icons.delete),
                    onPressed: () {},
                  )
                ],
                onPressed: () {},
                child: Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.type_specimen,
                    ),
                    title: Text(data.adiSoyadi ?? ""),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
