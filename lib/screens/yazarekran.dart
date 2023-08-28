import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/yazar_controller.dart';
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/Model/Yazar/yazar.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/screens/yazar_ekle_duzenle.dart';

import '../Model/Kullanici/kullanici.dart';

class YazarSayfasi extends StatelessWidget {
  YazarSayfasi(
      {Key? key, required this.kullanici, required this.secim, this.kitapID})
      : super(key: key);
  final cont = Get.put(YazarController());
  final KullaniciGiris kullanici;
  final int secim;
  final int? kitapID;
  final degisken = false.obs;

  // var kitaplar = kitapcontroller.GetKitap(
  //     kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController().obs;

    final contR = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      MetodModel z = MetodModel();
      z.kalinanSayfa = cont.simdikisayfa;
      z.islem = "sayfa";
      z.kullaniciAdi = kullanici.kullaniciAdi.toString();
      z.parola = kullanici.parola.toString();
      z.lkSayfa = true;

      var dd = await Get.put(YazarController()).getSayfaFiltreYazar(z);
      //print(cont.totalPageCount);
      cont.yazarliste = dd!;

      var yazarcont = Get.put(YazarController());

      contR.addListener(() async {
        if (contR.position.atEdge) {
          if (contR.position.pixels != 0.0) {
            if (yazarcont.totalPageCount! >= yazarcont.simdikisayfa!) {
              yazarcont.isloading = true;
              MetodModel x = MetodModel();
              x.kalinanSayfa = yazarcont.simdikisayfa;
              x.kullaniciAdi = kullanici.kullaniciAdi.toString();
              x.parola = kullanici.parola.toString();
              x.lkSayfa = false;

              MetodModel y = MetodModel();
              x.islem = "filtre";

              y.kalinanSayfa = yazarcont.simdikisayfa;
              y.kullaniciAdi = kullanici.kullaniciAdi.toString();
              y.parola = kullanici.parola.toString();
              y.lkSayfa = false;
              y.querry = yazarcont.filtrearama;
              yazarcont.filtresayfa
                  ? await Get.put(YazarController()).getSayfaFiltreYazar(y)
                  : await Get.put(YazarController()).getSayfaFiltreYazar(x);
              yazarcont.isloading = false;
            }
          }
        }
      });
    });
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            if (value.isEmpty) {
              degisken.value = true;
            } else {
              degisken.value = false;
            }
          },
          onSubmitted: (value) async {
            if (value != "") {
              final cont = Get.put(YazarController());
              cont.filtrearama = value;

              MetodModel z = MetodModel();
              z.kalinanSayfa = cont.simdikisayfa;
              z.kullaniciAdi = kullanici.kullaniciAdi.toString();
              z.parola = kullanici.parola.toString();
              z.lkSayfa = true;
              z.querry = value;
              Get.put(YazarController()).getSayfaFiltreYazar(z);
            }
          },
          controller: textEditingController.value,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
            hintText: " Ara...",
            border: const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Color.fromARGB(255, 103, 103, 103))),
            suffixIcon: Obx(
              () => IconButton(
                icon: Icon(degisken.value ? Icons.search : Icons.close),
                onPressed: degisken.value
                    ? () {}
                    : () async {
                        textEditingController.value.text = "";
                        final cont = Get.put(YazarController());
                        MetodModel z = MetodModel();
                        z.kalinanSayfa = cont.simdikisayfa;
                        z.islem = "sayfa";
                        z.kullaniciAdi = kullanici.kullaniciAdi.toString();
                        z.parola = kullanici.parola.toString();
                        z.lkSayfa = true;
                        Get.put(YazarController()).getSayfaFiltreYazar(z);

                        degisken.value = true;
                        cont.filtresayfa = false;
                      },
              ),
            ),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14.0),
        ),
        iconTheme: const IconThemeData(color: Color.fromRGBO(174, 166, 166, 1)),
        //  backgroundColor: Colors.white,
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
            () => GestureDetector(
              onTap: () {},
              child: ListView(
                controller: contR,
                shrinkWrap: true,
                children: [
                  ...cont.yazarliste.asMap().entries.map(
                        (data) => FocusedMenuHolder(
                          menuItems: [
                            FocusedMenuItem(
                                backgroundColor:
                                    const Color.fromARGB(255, 109, 107, 107),
                                title: const Text("Düzenle"),
                                trailingIcon: const Icon(Icons.edit),
                                onPressed: () async {
                                  var tekyazar = await YazarController()
                                      .getTekYazar(
                                          kullanici.kullaniciAdi.toString(),
                                          kullanici.parola.toString(),
                                          data.value.id);
                                  var result = await Get.to<Yazar>(
                                      YazarEkleDuzenleSayfasi(
                                    kullanici: kullanici,
                                    giristuru: "Düzenle",
                                    gelenyazar: tekyazar,
                                  ));

                                  if (result != null) {
                                    data.value.adiSoyadi = result.adiSoyadi;
                                    data.value.id = result.id;

                                    cont.refResh;

                                    Get.defaultDialog(
                                        title: "Yazar Güncellendi",
                                        middleText: "",
                                        backgroundColor: const Color.fromARGB(
                                            255, 141, 141, 141));
                                  }
                                }),
                            FocusedMenuItem(
                              backgroundColor:
                                  const Color.fromARGB(255, 110, 77, 77),
                              title: const Text("Sil"),
                              trailingIcon: const Icon(Icons.delete),
                              onPressed: () async {
                                var silindimi = await YazarController()
                                    .silYazar(kullanici.kullaniciAdi!.obs,
                                        kullanici.parola!.obs, data.value.id);
                                //  bool sil = await silindimi;
                                if (silindimi) {
                                  cont.yazarliste.removeAt(data.key);
                                } else {
                                  Get.defaultDialog(
                                      title: "Yazar Silinemedi",
                                      middleText: "Yazar Bir Öğrencide kayıtlı",
                                      backgroundColor: const Color.fromARGB(
                                          255, 110, 57, 57));
                                }
                              },
                            )
                          ],
                          onPressed: () async {
                            if (secim == 1) {
                              cont.secilenyazar = data.value.id;
                              if (cont.secilenyazar == data.value.id) {
                                var x = await Get.put(YazarController())
                                    .getTekYazar(
                                        kullanici.kullaniciAdi.toString(),
                                        kullanici.parola.toString(),
                                        data.value.id);

                                Get.back(result: x?.adiSoyadi);
                              }
                            }
                          },
                          child: Card(
                            child: ListTile(
                              leading: const Icon(
                                Icons.type_specimen,
                              ),
                              title: Text(data.value.adiSoyadi ?? ""),
                            ),
                          ),
                        ),
                      )
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
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
