import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/ogrenci_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/Model/Ogrenci/ogrenci.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/screens/ogrenci_ekle_duzenle.dart';

class OgrenciSayfasi extends StatelessWidget {
  OgrenciSayfasi(
      {Key? key,
      required this.kullanici,
      required this.secim,
      this.kitapID,
      required this.toplusec})
      : super(key: key);
  final cont = Get.put(OgrenciController());
  final KullaniciGiris kullanici;
  final int secim;
  final int? kitapID;
  final degisken = true.obs;
  final bool toplusec;

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

      var dd = await Get.put(OgrenciController()).getSayfaFiltreOgrenci(z);
      //print(cont.totalPageCount);
      cont.ogrenciliste = dd!;

      var ogrcont = Get.put(OgrenciController());

      contR.addListener(() async {
        if (contR.position.atEdge) {
          if (contR.position.pixels != 0.0) {
            if (ogrcont.totalPageCount! >= ogrcont.simdikisayfa!) {
              ogrcont.isloading = true;
              MetodModel x = MetodModel();
              x.kalinanSayfa = ogrcont.simdikisayfa;
              x.kullaniciAdi = kullanici.kullaniciAdi.toString();
              x.parola = kullanici.parola.toString();
              x.lkSayfa = false;

              MetodModel y = MetodModel();
              x.islem = "filtre";

              y.kalinanSayfa = ogrcont.simdikisayfa;
              y.kullaniciAdi = kullanici.kullaniciAdi.toString();
              y.parola = kullanici.parola.toString();
              y.lkSayfa = false;
              y.querry = ogrcont.filtrearama;
              ogrcont.filtresayfa
                  ? await Get.put(OgrenciController()).getSayfaFiltreOgrenci(y)
                  : await Get.put(OgrenciController()).getSayfaFiltreOgrenci(x);
              ogrcont.isloading = false;
            }
          }
        }
      });
    });
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        leading: Builder(
            builder: (context) => secim == 1 || secim == 2
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Get.back();
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.line_weight),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  )),
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
              final cont = Get.put(OgrenciController());
              cont.filtrearama = value;

              MetodModel z = MetodModel();
              z.kalinanSayfa = cont.simdikisayfa;
              z.kullaniciAdi = kullanici.kullaniciAdi.toString();
              z.parola = kullanici.parola.toString();
              z.lkSayfa = true;
              z.querry = value;
              Get.put(OgrenciController()).getSayfaFiltreOgrenci(z);
            }
          },
          controller: textEditingController.value,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
            hintText: " Öğrencide Ara...",
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
                        final cont = Get.put(OgrenciController());
                        MetodModel z = MetodModel();
                        z.kalinanSayfa = cont.simdikisayfa;
                        z.islem = "sayfa";
                        z.kullaniciAdi = kullanici.kullaniciAdi.toString();
                        z.parola = kullanici.parola.toString();
                        z.lkSayfa = true;
                        Get.put(OgrenciController()).getSayfaFiltreOgrenci(z);

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
          Obx(() => GestureDetector(
                onTap: () {},
                child: ListView(
                  controller: contR,
                  shrinkWrap: true,
                  children: [
                    ...cont.ogrenciliste.asMap().entries.map(
                          (data) => FocusedMenuHolder(
                            onPressed: () async {
                              if (secim == 1) {
                                cont.secilenogrenci = data.value.id;
                                if (cont.secilenogrenci == data.value.id) {
                                  var x = await Get.put(OgrenciController())
                                      .getTekOgrenci(
                                          kullanici.kullaniciAdi.toString(),
                                          kullanici.parola.toString(),
                                          data.value.id);

                                  Get.back(result: x);
                                }
                              } else if (secim == 2) {
                                cont.secilenogrenci = data.value.id;
                                if (cont.secilenogrenci == data.value.id) {
                                  var x = await Get.put(OgrenciController())
                                      .getTekOgrenci(
                                          kullanici.kullaniciAdi.toString(),
                                          kullanici.parola.toString(),
                                          data.value.id);

                                  Get.back(result: x);
                                }
                              }
                            },
                            menuItems: [
                              FocusedMenuItem(
                                  backgroundColor:
                                      const Color.fromARGB(255, 109, 107, 107),
                                  title: const Text("Düzenle"),
                                  trailingIcon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    var tekogrenci = await OgrenciController()
                                        .getTekOgrenci(
                                            kullanici.kullaniciAdi.toString(),
                                            kullanici.parola.toString(),
                                            data.value.id);
                                    var result = await Get.to<Ogrenci>(
                                        OgrenciEkleDuzenleSayfasi(
                                      kullanici: kullanici,
                                      giristuru: "Düzenle",
                                      gelenogrenci: tekogrenci,
                                    ));

                                    if (result != null) {
                                      data.value.adiSoyadi = result.adiSoyadi;
                                      data.value.id = result.id;

                                      cont.refResh;

                                      Get.defaultDialog(
                                          title: "Öğrenci Güncellendi",
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
                                  var silindimi = await OgrenciController()
                                      .silOgrenci(kullanici.kullaniciAdi!.obs,
                                          kullanici.parola!.obs, data.value.id);
                                  //  bool sil = await silindimi;
                                  if (silindimi) {
                                    cont.ogrenciliste.removeAt(data.key);
                                  } else {
                                    Get.defaultDialog(
                                        title: "Öğrenci Silinemedi",
                                        middleText:
                                            "Öğrenci Bir Kitap teslimde kayıtlı",
                                        backgroundColor: const Color.fromARGB(
                                            255, 110, 57, 57));
                                  }
                                },
                              )
                            ],
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
              )),
          Positioned(
            right: 10,
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
                  Get.to(OgrenciEkleDuzenleSayfasi(
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
