import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitapturu_controller.dart';
import 'package:kutuphane_mobil_d/screens/kitaptur_ekle_duzenle.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';

import '../Model/Kullanici/kullanici.dart';

class KitapTurSayfasi extends StatelessWidget {
  KitapTurSayfasi({Key? key, required this.kullanici}) : super(key: key);
  final cont = Get.put(KitapTurController());
  final KullaniciGiris kullanici;
  // var kitaplar = kitapcontroller.GetKitap(
  //     kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Kitap Türü Sayfası'),
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
              itemCount: cont.kitapturList.length,
              itemBuilder: (context, index) {
                var data = cont.kitapturList[index];
                return FocusedMenuHolder(
                  menuItems: [
                    FocusedMenuItem(
                        backgroundColor:
                            const Color.fromARGB(255, 109, 107, 107),
                        title: const Text("Düzenle"),
                        trailingIcon: const Icon(Icons.edit),
                        onPressed: () async {
                          var tekitaptur = await KitapTurController()
                              .getTekKitapTur(kullanici.kullaniciAdi.toString(),
                                  kullanici.parola.toString(), data.id);

                          Get.to(KitapTurEkleDuzenleSayfasi(
                            kullanici: kullanici,
                            giristuru: "Düzenle",
                            gelenkitaptur: tekitaptur,
                          ));
                        }),
                    FocusedMenuItem(
                      backgroundColor: const Color.fromARGB(255, 110, 77, 77),
                      title: const Text("Sil"),
                      trailingIcon: const Icon(Icons.delete),
                      onPressed: () async {
                        var silindimi = await KitapTurController().silKitapTuru(
                            kullanici.kullaniciAdi, kullanici.parola, data.id);
                        //  bool sil = await silindimi;
                        if (silindimi) {
                          cont.kitapturList.removeAt(index);
                        } else {
                          Get.defaultDialog(
                              title: "Kitap Türü Silinemedi",
                              middleText: "Kitap Türü Bir Kitapta kayıtlı",
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
                  var dd = await Get.put(KitapTurController()).getKitapTur(
                      kullanici.kullaniciAdi.toString(),
                      kullanici.parola.toString());

                  Get.put(KitapTurController()).kitapturList = dd ?? [];
                  Get.back();

                  Get.to(KitapTurEkleDuzenleSayfasi(
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
