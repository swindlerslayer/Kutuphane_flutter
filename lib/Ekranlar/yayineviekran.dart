import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav_drawer.dart';
import 'package:kutuphane_mobil_d/Ekranlar/yayinevi_ekle_duzenle.dart';

import '../Model/kullanici.dart';

class YayineviSayfasi extends StatelessWidget {
  YayineviSayfasi({Key? key, required this.kullanici}) : super(key: key);
  final cont = Get.put(YayineviController());
  final KullaniciGiris kullanici;
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
        title: const Text('Yayinevi Sayfası'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 121, 121, 121),
              Color.fromARGB(255, 44, 44, 44),
            ],
          ),
        ),
        child: Stack(fit: StackFit.expand, children: [
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: cont.yayineviliste.length,
              itemBuilder: (context, index) {
                var data = cont.yayineviliste[index];
                return FocusedMenuHolder(
                  menuItems: [
                    FocusedMenuItem(
                        backgroundColor:
                            const Color.fromARGB(255, 109, 107, 107),
                        title: const Text("Düzenle"),
                        trailingIcon: const Icon(Icons.edit),
                        onPressed: () async {
                          var tekyayinevi = await YayineviController()
                              .getTekYayinevi(kullanici.kullaniciAdi.toString(),
                                  kullanici.parola.toString(), data.id);

                          Get.to(YayineviEkleDuzenleSayfasi(
                            kullanici: kullanici,
                            giristuru: "Düzenle",
                            gelenyayinevi: tekyayinevi,
                          ));
                        }),
                    FocusedMenuItem(
                      backgroundColor: const Color.fromARGB(255, 110, 77, 77),
                      title: const Text("Sil"),
                      trailingIcon: const Icon(Icons.delete),
                      onPressed: () async {
                        var silindimi = await YayineviController().silYayinevi(
                            kullanici.kullaniciAdi, kullanici.parola, data.id);
                        //  bool sil = await silindimi;
                        if (silindimi) {
                          cont.yayineviliste.removeAt(index);
                        } else {
                          Get.defaultDialog(
                              title: "Yayınevi Silinemedi",
                              middleText: "Yayınevi Bir Kitapta kayıtlı",
                              backgroundColor:
                                  const Color.fromARGB(255, 110, 57, 57));
                        }
                      },
                    )
                  ],
                  onPressed: () {},
                  child: Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.type_specimen,
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
                  var dd = await Get.put(YayineviController()).getYayinevi(
                      kullanici.kullaniciAdi.toString(),
                      kullanici.parola.toString());

                  Get.put(YayineviController()).yayineviliste = dd ?? [];
                  Get.back();

                  Get.to(YayineviEkleDuzenleSayfasi(
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
        ]),
      ),
    );
  }
}
