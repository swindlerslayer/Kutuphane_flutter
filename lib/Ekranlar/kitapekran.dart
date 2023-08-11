import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

import 'kitap_ekle_duzenle.dart';

class KitapSayfasi extends StatelessWidget {
  KitapSayfasi({Key? key, this.kullanici}) : super(key: key);
  final cont = Get.put(KitapController());
  final kullanici;
  // var kitaplar = kitapcontroller.GetKitap(
  //     kullanici.kullaniciAdi.toString(), kullanici.parola.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Kitap Sayfası'),
      ),
      body: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          itemCount: cont.kitapList.length,
          itemBuilder: (context, index) {
            var data = cont.kitapList[index];
            return FocusedMenuHolder(
              menuItems: [
                FocusedMenuItem(
                    backgroundColor: const Color.fromARGB(255, 110, 107, 107),
                    title: const Text("Düzenle"),
                    trailingIcon: const Icon(Icons.edit),
                    onPressed: () async {
                      var tekkitap = await KitapController().getTekKitap(
                          kullanici.kullaniciAdi.toString(),
                          kullanici.parola.toString(),
                          data.id);
                      Get.to(KitapEkleDuzenleSayfasi(
                        kullanici: kullanici,
                        giristuru: "Düzenle",
                        gelenkitap: tekkitap,
                      ));
                      print('Focus iç item basıldı');
                    }),
                FocusedMenuItem(
                  backgroundColor: const Color.fromARGB(255, 110, 77, 77),
                  title: const Text("Sil"),
                  trailingIcon: const Icon(Icons.delete),
                  onPressed: () async {
                    var silindimi = await KitapController().silKitap(
                        kullanici.kullaniciAdi, kullanici.parola, data.id);
                    //  bool sil = await silindimi;
                    if (silindimi) {
                      cont.kitapList.removeAt(index);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Kitap Silinemiyor'),
                            backgroundColor: Color.fromARGB(255, 110, 57, 57)),
                      );
                    }
                  },
                )
              ],
              onPressed: () {},
              child: Card(
                child: ListTile(
                  subtitle: Text(
                      'Yazarı :  ${data.yazarAdi ?? ""}                                              '),
                  leading: const Icon(
                    Icons.menu_book_rounded,
                  ),
                  title: Text(data.adi ?? ""),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
