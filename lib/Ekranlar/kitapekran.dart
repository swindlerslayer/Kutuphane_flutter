import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Degiskenler/kullanici.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav_drawer.dart';

import '../Controllers/kitapturu_controller.dart';
import '../Controllers/yayinevi_controller.dart';
import '../Controllers/yazar_controller.dart';
import 'kitap_ekle_duzenle.dart';

class KitapSayfasi extends StatelessWidget {
  const KitapSayfasi({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;
  // var kitaplar = kitapcontroller.GetKitap(
  //     kullanici.kullaniciAdi.toString(), kullanici.parola.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Kitap Sayfası'),
      ),
      body: BodyWidget(kullanici: kullanici),
    );
  }
}

class BodyWidget extends StatelessWidget {
  BodyWidget({super.key, required this.kullanici});
  final cont = Get.put(KitapController());
  final KullaniciGiris kullanici;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Obx(
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
                        var dd = await Get.put(YazarController()).getYazar(
                            kullanici.kullaniciAdi.toString(),
                            kullanici.parola.toString());
                        var dd1 = await Get.put(KitapTurController())
                            .getKitapTur(kullanici.kullaniciAdi.toString(),
                                kullanici.parola.toString());
                        var dd2 = await Get.put(YayineviController())
                            .getYayinevi(kullanici.kullaniciAdi.toString(),
                                kullanici.parola.toString());
                        Get.put(YayineviController()).yayineviliste = dd2 ?? [];
                        Get.back();
                        Get.put(KitapTurController()).kitapturList = dd1 ?? [];
                        Get.back();
                        Get.put(YazarController()).yazarliste = dd ?? [];
                        Get.back();

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
                              backgroundColor:
                                  Color.fromARGB(255, 110, 57, 57)),
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
        Positioned(
          right: 10,
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () async {
                var dd = await Get.put(YazarController()).getYazar(
                    kullanici.kullaniciAdi.toString(),
                    kullanici.parola.toString());
                var dd1 = await Get.put(KitapTurController()).getKitapTur(
                    kullanici.kullaniciAdi.toString(),
                    kullanici.parola.toString());
                var dd2 = await Get.put(YayineviController()).getYayinevi(
                    kullanici.kullaniciAdi.toString(),
                    kullanici.parola.toString());
                Get.put(YayineviController()).yayineviliste = dd2 ?? [];
                Get.back();
                Get.put(KitapTurController()).kitapturList = dd1 ?? [];
                Get.back();
                Get.put(YazarController()).yazarliste = dd ?? [];
                Get.back();

                Get.to(KitapEkleDuzenleSayfasi(
                  kullanici: kullanici,
                  giristuru: "Ekle",
                ));
              },
              child: const CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 138, 137, 137),
                child: Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
