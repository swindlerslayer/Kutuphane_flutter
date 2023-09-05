import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/Model/Yayinevi/yayinevi.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/screens/yayinevi_ekle_duzenle.dart';

class YayineviSayfasi extends StatelessWidget {
  YayineviSayfasi(
      {Key? key, required this.kullanici, required this.secim, this.kitapID})
      : super(key: key);
  final cont = Get.put(YayineviController());
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

      var dd = await Get.put(YayineviController()).getSayfaFiltreYayinevi(z);
      //print(cont.totalPageCount);
      cont.yayineviliste = dd!;

      var yayinevicont = Get.put(YayineviController());

      contR.addListener(() async {
        if (contR.position.atEdge) {
          if (contR.position.pixels != 0.0) {
            if (yayinevicont.totalPageCount! >= yayinevicont.simdikisayfa!) {
              yayinevicont.isloading = true;
              MetodModel x = MetodModel();
              x.kalinanSayfa = yayinevicont.simdikisayfa;
              x.kullaniciAdi = kullanici.kullaniciAdi.toString();
              x.parola = kullanici.parola.toString();
              x.lkSayfa = false;

              MetodModel y = MetodModel();
              x.islem = "filtre";

              y.kalinanSayfa = yayinevicont.simdikisayfa;
              y.kullaniciAdi = kullanici.kullaniciAdi.toString();
              y.parola = kullanici.parola.toString();
              y.lkSayfa = false;
              y.querry = yayinevicont.filtrearama;
              yayinevicont.filtresayfa
                  ? await Get.put(YayineviController())
                      .getSayfaFiltreYayinevi(y)
                  : await Get.put(YayineviController())
                      .getSayfaFiltreYayinevi(x);
              yayinevicont.isloading = false;
            }
          }
        }
      });
    });
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        leading: Builder(
            builder: (context) => secim == 1
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
              final cont = Get.put(YayineviController());
              cont.filtrearama = value;

              MetodModel z = MetodModel();
              z.kalinanSayfa = cont.simdikisayfa;
              z.kullaniciAdi = kullanici.kullaniciAdi.toString();
              z.parola = kullanici.parola.toString();
              z.lkSayfa = true;
              z.querry = value;
              Get.put(YayineviController()).getSayfaFiltreYayinevi(z);
            }
          },
          controller: textEditingController.value,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
            hintText: " Yayınevinde Ara...",
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
                        final cont = Get.put(YayineviController());
                        MetodModel z = MetodModel();
                        z.kalinanSayfa = cont.simdikisayfa;
                        z.islem = "sayfa";
                        z.kullaniciAdi = kullanici.kullaniciAdi.toString();
                        z.parola = kullanici.parola.toString();
                        z.lkSayfa = true;
                        Get.put(YayineviController()).getSayfaFiltreYayinevi(z);

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
                  ...cont.yayineviliste.asMap().entries.map(
                        (data) => FocusedMenuHolder(
                          menuItems: [
                            FocusedMenuItem(
                                backgroundColor:
                                    const Color.fromARGB(255, 109, 107, 107),
                                title: const Text("Düzenle"),
                                trailingIcon: const Icon(Icons.edit),
                                onPressed: () async {
                                  var tekyayinevi = await YayineviController()
                                      .getTekYayinevi(
                                          kullanici.kullaniciAdi.toString(),
                                          kullanici.parola.toString(),
                                          data.value.id);
                                  var result = await Get.to<Yayinevi>(
                                      YayineviEkleDuzenleSayfasi(
                                    kullanici: kullanici,
                                    giristuru: "Düzenle",
                                    gelenyayinevi: tekyayinevi,
                                  ));

                                  if (result != null) {
                                    data.value.adi = result.adi;
                                    data.value.id = result.id;

                                    cont.refResh;

                                    Get.defaultDialog(
                                        title: "Yayınevi Güncellendi",
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
                                var silindimi = await YayineviController()
                                    .silYayinevi(kullanici.kullaniciAdi!.obs,
                                        kullanici.parola!.obs, data.value.id);
                                //  bool sil = await silindimi;
                                if (silindimi) {
                                  cont.yayineviliste.removeAt(data.key);
                                } else {
                                  Get.defaultDialog(
                                      title: "Yayınevi Silinemedi",
                                      middleText:
                                          "Yayınevi Bir Öğrencide kayıtlı",
                                      backgroundColor: const Color.fromARGB(
                                          255, 110, 57, 57));
                                }
                              },
                            )
                          ],
                          onPressed: () async {
                            if (secim == 1) {
                              cont.secilenyayinevi = data.value.id;
                              if (cont.secilenyayinevi == data.value.id) {
                                var x = await Get.put(YayineviController())
                                    .getTekYayinevi(
                                        kullanici.kullaniciAdi.toString(),
                                        kullanici.parola.toString(),
                                        data.value.id);

                                Get.back(result: x?.adi);
                              }
                            }
                          },
                          child: Card(
                            child: ListTile(
                              leading: const Icon(
                                Icons.type_specimen,
                              ),
                              title: Text(data.value.adi ?? ""),
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
