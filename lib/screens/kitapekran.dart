import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kitap/kitap.dart';
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/Controllers/kitapturu_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/yazar_controller.dart';
import 'kitap_ekle_duzenle.dart';

class KitapSayfasi extends StatelessWidget {
  KitapSayfasi({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;
  final degisken = true.obs;
  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController().obs;

    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: TextField(
          autofocus: false,
          onChanged: (value) {
            if (value.isEmpty) {
              degisken.value = true;
            } else {
              degisken.value = false;
            }
          },
          onSubmitted: (value) async {
            if (value != "") {
              final cont = Get.put(KitapController());
              cont.filtrearama = value;

              MetodModel z = MetodModel();
              z.kalinanSayfa = cont.simdikisayfa;
              z.kullaniciAdi = kullanici.kullaniciAdi.toString();
              z.parola = kullanici.parola.toString();
              z.lkSayfa = true;
              z.querry = value;
              Get.put(KitapController()).getSayfaFiltreKitap(z);
            }
          },
          controller: textEditingController.value,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
            hintText: " Kitapta Ara...",
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
                        final cont = Get.put(KitapController());
                        MetodModel z = MetodModel();
                        z.kalinanSayfa = cont.simdikisayfa;
                        z.islem = "sayfa";
                        z.kullaniciAdi = kullanici.kullaniciAdi.toString();
                        z.parola = kullanici.parola.toString();
                        z.lkSayfa = true;
                        Get.put(KitapController()).getSayfaFiltreKitap(z);

                        degisken.value = true;
                        cont.filtresayfa = false;
                      },
              ),
            ),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14.0),
        ),
        iconTheme: const IconThemeData(color: Color.fromRGBO(174, 166, 166, 1)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () async {
              //arama filtre kısmı\\
              
            },
          ),
        ],
        //  backgroundColor: Colors.white,
      ),
      body: BodyWidget(kullanici: kullanici),
    );
  }
}

@override
class BodyWidget extends StatelessWidget {
  BodyWidget({super.key, required this.kullanici});
  final cont = Get.put(KitapController());
  final contyazzar = Get.put(YazarController());
  final contkitapturu = Get.put(KitapTurController());
  final contyayinevi = Get.put(YayineviController());

  final KullaniciGiris kullanici;
  final contR = ScrollController();

  @override
  Widget build(BuildContext context) {
    final kitcont = Get.put(KitapController());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      MetodModel z = MetodModel();
      z.kalinanSayfa = kitcont.simdikisayfa;
      z.islem = "sayfa";
      z.kullaniciAdi = kullanici.kullaniciAdi.toString();
      z.parola = kullanici.parola.toString();
      z.lkSayfa = true;

      var dd = await Get.put(KitapController()).getSayfaFiltreKitap(z);
      //print(cont.totalPageCount);
      cont.sayfakitapList = dd;
      contR.addListener(() async {
        if (contR.position.atEdge) {
          if (contR.position.pixels != 0.0) {
            if (kitcont.totalPageCount! >= kitcont.simdikisayfa) {
              kitcont.isloading = true;
              MetodModel x = MetodModel();
              x.kalinanSayfa = kitcont.simdikisayfa;
              x.kullaniciAdi = kullanici.kullaniciAdi.toString();
              x.parola = kullanici.parola.toString();
              x.lkSayfa = false;

              MetodModel y = MetodModel();
              x.islem = "filtre";

              y.kalinanSayfa = kitcont.simdikisayfa;
              y.kullaniciAdi = kullanici.kullaniciAdi.toString();
              y.parola = kullanici.parola.toString();
              y.lkSayfa = false;
              y.querry = kitcont.filtrearama;
              kitcont.filtresayfa
                  ? await Get.put(KitapController()).getSayfaFiltreKitap(y)
                  : await Get.put(KitapController()).getSayfaFiltreKitap(x);
              kitcont.isloading = false;
            }
          }
        }
      });
    });

    return Container(
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          Obx(
            () => ListView(
              shrinkWrap: true,
              controller: contR,
              children: [
                ...cont.sayfakitapList!.asMap().entries.map(
                      (data) => FocusedMenuHolder(
                        menuItems: [
                          FocusedMenuItem(
                              backgroundColor:
                                  const Color.fromARGB(255, 110, 107, 107),
                              title: const Text("Düzenle"),
                              trailingIcon: const Icon(Icons.edit),
                              onPressed: () async {
                                var tekkitap = await KitapController()
                                    .getTekKitap(
                                        kullanici.kullaniciAdi.toString(),
                                        kullanici.parola.toString(),
                                        data.value.id);

                                await Get.put(YazarController()).getTekYazar(
                                    kullanici.kullaniciAdi.toString(),
                                    kullanici.parola.toString(),
                                    data.value.yazarId);
                                await Get.put(YayineviController())
                                    .getTekYayinevi(
                                        kullanici.kullaniciAdi.toString(),
                                        kullanici.parola.toString(),
                                        data.value.yayinEviId);
                                await Get.put(KitapTurController())
                                    .getTekKitapTur(
                                        kullanici.kullaniciAdi.toString(),
                                        kullanici.parola.toString(),
                                        data.value.kitapTurId);

                                var result = await Get.to<Kitap>(
                                    () => KitapEkleDuzenleSayfasi(
                                          kullanici: kullanici,
                                          giristuru: "Düzenle",
                                          gelenkitap: tekkitap,
                                        ));
                                if (result != null) {
                                  data.value.adi = result.adi;
                                  data.value.sayfaSayisi = result.sayfaSayisi;
                                  data.value.barkod = result.barkod;
                                  data.value.degisiklikTarihi =
                                      result.degisiklikTarihi;
                                  data.value.degisiklikYapan =
                                      result.degisiklikYapan;
                                  data.value.kayitTarihi = result.kayitTarihi;
                                  data.value.kayitYapan = result.kayitYapan;
                                  data.value.kitapTurId = result.kitapTurId;
                                  data.value.yayinEviId = result.yayinEviId;
                                  data.value.yazarId = result.yazarId;
                                  data.value.adiSoyadi = result.adisoyadi;
                                  data.value.resim = result.resim;
                                  cont.refResh;
                                  Get.defaultDialog(
                                      title: "Kitap Güncellendi",
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
                              var silindimi = await KitapController().silKitap(
                                  kullanici.kullaniciAdi!.obs,
                                  kullanici.parola!.obs,
                                  data.value.id);
                              //  bool sil = await silindimi;
                              if (silindimi) {
                                cont.sayfakitapList?.removeAt(data.key);
                              } else {
                                Get.defaultDialog(
                                    title: "Kitap Silinemedi",
                                    middleText: "Kitap Bir Öğrencide kayıtlı",
                                    backgroundColor:
                                        const Color.fromARGB(255, 110, 57, 57));
                              }
                            },
                          )
                        ],
                        onPressed: () {},
                        child: Card(
                          child: ListTile(
                            subtitle: Text(
                                'Yazarı :  ${data.value.adiSoyadi ?? ""}                                         '),
                            leading: const Icon(
                              Icons.menu_book_rounded,
                            ),
                            title: Text(data.value.adi ?? ""),
                          ),
                        ),
                      ),
                    ),
                cont.isloading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      )
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
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
      ),
    );
  }
}
