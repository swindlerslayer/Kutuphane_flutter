import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/logincontrols.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import '../Controllers/kitapturu_controller.dart';
import '../Controllers/yayinevi_controller.dart';
import '../Controllers/yazar_controller.dart';
import 'kitap_ekle_duzenle.dart';

class KitapSayfasi extends StatelessWidget {
  const KitapSayfasi({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
              hintText: " Ara...",
              border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Color.fromARGB(255, 103, 103, 103))),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              )),
          style: const TextStyle(color: Colors.white, fontSize: 14.0),
        ),
        iconTheme: const IconThemeData(color: Color.fromRGBO(174, 166, 166, 1)),
        //  backgroundColor: Colors.white,
      ),
      body: BodyWidget(kullanici: kullanici),
    );
  }
}

// Future<void> getMorePostList() async {
//   scrollController.addListener(() async {
//     if (scrollController.position.maxScrollExtent ==
//         scrollController.position.pixels) {
//       final kitcont = Get.put(KitapController());
//       final cont = Get.put(LoginController());
//       var dl = await Get.put(KitapController()).getSayfaKitap(
//           cont.kullanicigiris?.kullaniciAdi.toString(),
//           cont.kullanicigiris?.parola.toString(),
//           kitcont.totalPageCount,
//           false);
//       kitcont.sayfakitapList?.addAll(dl!);
//       print(dl);
//     }
//   });
// }

ScrollController scrollController = ScrollController();

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final kitcont = Get.put(KitapController());

      var kacincisayfa = kitcont.totalPageCount;

      var yy = await Get.put(YazarController().getYazar(
          kullanici.kullaniciAdi.toString(), kullanici.parola.toString()));
      contyazzar.yazarliste = yy!;

      var dd = await Get.put(KitapController()).getSayfaKitap(
          kullanici.kullaniciAdi.toString(),
          kullanici.parola.toString(),
          cont.simdikisayfa,
          true);
      //print(cont.totalPageCount);
      cont.sayfakitapList = dd;
      contR.addListener(() async {
        if (contR.position.atEdge) {
          if (contR.position.pixels != 0.0) {
            if (kitcont.totalPageCount! > kitcont.sayfakitapList!.length) {
              final cont = Get.put(LoginController());
              var dl = await Get.put(KitapController()).getSayfaKitap(
                  cont.kullanicigiris.kullaniciAdi.toString(),
                  cont.kullanicigiris.parola.toString(),
                  kitcont.simdikisayfa,
                  false);
              print(dl);

              print("Kacincisayfa: $kacincisayfa");
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
                                var dd = await Get.put(YazarController())
                                    .getYazar(kullanici.kullaniciAdi.toString(),
                                        kullanici.parola.toString());
                                var dd1 = await Get.put(KitapTurController())
                                    .getKitapTur(
                                        kullanici.kullaniciAdi.toString(),
                                        kullanici.parola.toString());
                                var dd2 = await Get.put(YayineviController())
                                    .getYayinevi(
                                        kullanici.kullaniciAdi.toString(),
                                        kullanici.parola.toString());
                                Get.put(YayineviController()).yayineviliste =
                                    dd2 ?? [];
                                // Get.back();
                                Get.put(KitapTurController()).kitapturList =
                                    dd1 ?? [];
                                // Get.back();
                                Get.put(YazarController()).yazarliste =
                                    dd ?? [];
                                // Get.back();
                                Get.to(() => KitapEkleDuzenleSayfasi(
                                      kullanici: kullanici,
                                      giristuru: "Düzenle",
                                      gelenkitap: tekkitap,
                                    ));
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
                  Get.put(KitapTurController()).kitapturList = dd1 ?? [];
                  Get.put(YazarController()).yazarliste = dd ?? [];
                  Get.to(KitapEkleDuzenleSayfasi(
                    kullanici: kullanici,
                    giristuru: "Ekle",
                  ));
                  // Get.to(() => KitapEkleDuzenleSayfasi(
                  //       kullanici: kullanici,
                  //       giristuru: "Ekle",
                  //     ));
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
