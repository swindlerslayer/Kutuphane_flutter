import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/yazar_controller.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/screens/yazar_ekle_duzenle.dart';

import '../Model/Kullanici/kullanici.dart';

class YazarSayfasi extends StatelessWidget {
  YazarSayfasi({Key? key, required this.kullanici}) : super(key: key);
  final cont = Get.put(YazarController());
  final KullaniciGiris kullanici;
  // var kitaplar = kitapcontroller.GetKitap(
  //     kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var dd = await Get.put(YazarController()).getYazar(
          kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
      Get.put(YazarController()).yazarliste = dd ?? [];
    });
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Yazar Sayfası'),
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
              itemCount: cont.yazarliste.length,
              itemBuilder: (context, index) {
                var data = cont.yazarliste[index];
                return FocusedMenuHolder(
                  menuItems: [
                    FocusedMenuItem(
                        backgroundColor:
                            const Color.fromARGB(255, 109, 107, 107),
                        title: const Text("Düzenle"),
                        trailingIcon: const Icon(Icons.edit),
                        onPressed: () async {
                          var tekyazar = await YazarController().getTekYazar(
                              kullanici.kullaniciAdi.toString(),
                              kullanici.parola.toString(),
                              data.id);

                          Get.to(YazarEkleDuzenleSayfasi(
                            kullanici: kullanici,
                            giristuru: "Düzenle",
                            gelenyazar: tekyazar,
                          ));
                        }),
                    FocusedMenuItem(
                      backgroundColor: const Color.fromARGB(255, 110, 77, 77),
                      title: const Text("Sil"),
                      trailingIcon: const Icon(Icons.delete),
                      onPressed: () async {
                        var silindimi = await YazarController().silYazar(
                            kullanici.kullaniciAdi!.obs,
                            kullanici.parola!.obs,
                            data.id);
                        //  bool sil = await silindimi;
                        if (silindimi) {
                          cont.yazarliste.removeAt(index);
                        } else {
                          Get.defaultDialog(
                              title: "Yazar Silinemedi",
                              middleText: "Yazar Bir Öğrencide kayıtlı",
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
                      title: Text(data.adiSoyadi ?? ""),
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

                  Get.put(YazarController()).yazarliste = dd ?? [];

                  Get.to(YazarEkleDuzenleSayfasi(
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
