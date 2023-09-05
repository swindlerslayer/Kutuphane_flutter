import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/anasayfa_controller.dart';
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/Model/OgrenciKitap/ogrenci_kitap.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';

class NewScreen extends StatelessWidget {
  NewScreen({Key? key, required this.kullanici}) : super(key: key);
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
              final cont = Get.put(AnasayfaController());
              cont.filtrearama = value;

              MetodModel z = MetodModel();
              z.kalinanSayfa = cont.simdikisayfa;
              z.kullaniciAdi = kullanici.kullaniciAdi.toString();
              z.parola = kullanici.parola.toString();
              z.lkSayfa = true;
              z.querry = value;
              Get.put(AnasayfaController()).getSayfaFiltreOgrenciKitap(z);
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
                        final cont = Get.put(AnasayfaController());
                        MetodModel z = MetodModel();
                        z.kalinanSayfa = cont.simdikisayfa;
                        z.islem = "sayfa";
                        z.kullaniciAdi = kullanici.kullaniciAdi.toString();
                        z.parola = kullanici.parola.toString();
                        z.lkSayfa = true;
                        Get.put(AnasayfaController())
                            .getSayfaFiltreOgrenciKitap(z);

                        degisken.value = true;
                        cont.filtresayfa = false;
                      },
              ),
            ),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
      body: BodyWidget(kullanici: kullanici),
    );
  }
}
//sayfaogrencikitapList

class BodyWidget extends StatelessWidget {
  BodyWidget({super.key, required this.kullanici});
  final cont = Get.put(AnasayfaController());
  final KullaniciGiris kullanici;
  final contR = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        //    var dd = await Get.put(AnasayfaController()).getOgrenciKitap(
        //       kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
        //  Get.put(AnasayfaController()).kitapogrenci = dd ?? [];
        MetodModel z = MetodModel();
        z.kalinanSayfa = cont.simdikisayfa;
        z.islem = "sayfa";
        z.kullaniciAdi = kullanici.kullaniciAdi.toString();
        z.parola = kullanici.parola.toString();
        z.lkSayfa = true;
        z.artanazalan = false;
        var dd =
            await Get.put(AnasayfaController()).getSayfaFiltreOgrenciKitap(z);

        //print(cont.totalPageCount);
        cont.sayfaogrencikitapList = dd;
        contR.addListener(
          () async {
            if (contR.position.atEdge) {
              if (contR.position.pixels != 0.0) {
                if (cont.totalPageCount! >= cont.simdikisayfa) {
                  cont.isloading = true;
                  MetodModel x = MetodModel();
                  x.kalinanSayfa = cont.simdikisayfa;
                  x.kullaniciAdi = kullanici.kullaniciAdi.toString();
                  x.parola = kullanici.parola.toString();
                  x.lkSayfa = false;
                  z.artanazalan = false;

                  MetodModel y = MetodModel();
                  x.islem = "filtre";

                  y.kalinanSayfa = cont.simdikisayfa;
                  y.kullaniciAdi = kullanici.kullaniciAdi.toString();
                  y.parola = kullanici.parola.toString();
                  y.lkSayfa = false;
                  y.querry = cont.filtrearama;
                  y.artanazalan = false;
                  cont.filtresayfa
                      ? await Get.put(AnasayfaController())
                          .getSayfaFiltreOgrenciKitap(y)
                      : await Get.put(AnasayfaController())
                          .getSayfaFiltreOgrenciKitap(x);
                  cont.isloading = false;
                }
              }
            }
          },
        );
      },
    );
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
            () => ListView(controller: contR, shrinkWrap: true, children: [
              ...cont.sayfaogrencikitapList!.asMap().entries.map((data) =>
                  FocusedMenuHolder(
                    onPressed: () {},
                    menuItems: [
                      FocusedMenuItem(
                        backgroundColor:
                            const Color.fromARGB(255, 110, 107, 107),
                        title: const Text("Teslim Alındı"),
                        trailingIcon: const Icon(Icons.edit),
                        onPressed: () async {
                          var gelenok = cont.getTekOgrenciKitap(
                              kullanici.kullaniciAdi!,
                              kullanici.parola!,
                              data.value.id); // data.id
                          var ogrencikitap = await gelenok;

                          OgrenciKitap ok = OgrenciKitap();

                          ok.teslimTarihi = DateTime.now().toString();
                          ok.teslimDurumu = true;
                          ok.ogrenciId = ogrencikitap?.ogrenciId;
                          ok.kitapId = ogrencikitap?.kitapId;
                          ok.kullancId = ogrencikitap?.kullancId;
                          ok.kayitTarihi = ogrencikitap?.kayitTarihi;
                          ok.degisiklikYapan =
                              kullanici.kullaniciAdi.toString();
                          ok.alisTarihi = ogrencikitap?.alisTarihi;
                          ok.id = data.value.id;
                          data.value.teslimDurumu = true;

                          var kaydetGuncelleKontrol = await AnasayfaController()
                              .ekleguncelleOgrenciKitap(
                                  kullanici.kullaniciAdi!.obs,
                                  kullanici.parola!.obs,
                                  ok);
                          if (kaydetGuncelleKontrol == "Güncellendi") {
                            Get.defaultDialog(
                                title: "Teslim Alındı!",
                                middleText: "",
                                backgroundColor:
                                    const Color.fromARGB(255, 141, 141, 141));
                          }
                          cont.refResh();
                        },
                      ),
                      FocusedMenuItem(
                        backgroundColor: const Color.fromARGB(255, 110, 57, 57),
                        title: const Text("Teslim Alınmadı"),
                        trailingIcon: const Icon(Icons.edit),
                        onPressed: () async {
                          var gelenok = cont.getTekOgrenciKitap(
                              kullanici.kullaniciAdi!,
                              kullanici.parola!,
                              data.value.id); // data.id
                          var ogrencikitap = await gelenok;

                          OgrenciKitap ok = OgrenciKitap();

                          ok.teslimDurumu = false;
                          ok.ogrenciId = ogrencikitap?.ogrenciId;
                          ok.kitapId = ogrencikitap?.kitapId;
                          ok.kullancId = ogrencikitap?.kullancId;
                          ok.kayitTarihi = ogrencikitap?.kayitTarihi;
                          ok.alisTarihi = ogrencikitap?.alisTarihi;
                          ok.degisiklikYapan =
                              kullanici.kullaniciAdi.toString();
                          ok.degisiklikTarihi = DateTime.now().toString();
                          ok.id = data.value.id;
                          data.value.teslimDurumu = false;

                          var kaydetGuncelleKontrol = await AnasayfaController()
                              .ekleguncelleOgrenciKitap(
                                  kullanici.kullaniciAdi!.obs,
                                  kullanici.parola!.obs,
                                  ok);
                          if (kaydetGuncelleKontrol == "Güncellendi") {
                            Get.defaultDialog(
                                title: "Teslim Alınmadı!",
                                middleText: "",
                                backgroundColor:
                                    const Color.fromARGB(255, 141, 141, 141));
                          }
                          cont.refResh();
                        },
                      )
                    ],
                    child: SizedBox(
                      height: 75,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.book_rounded),
                            Container(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        children: <TextSpan>[
                                          const TextSpan(
                                              text: 'Öğrenci Adı: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: '${data.value.adiSoyadi} '),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        children: <TextSpan>[
                                          const TextSpan(
                                              text: 'Kitap Adı :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(text: '${data.value.adi}'),
                                        ],
                                      ),
                                    ),

                                    Text(
                                        'Okul Numarası: ${data.value.okulNo.toString()}'),
                                    //  Text('${data.alisTarihi}'),
                                    // Text(
                                    //     '${DateFormat.yMd().parse(data.alisTarihi!, false)}      ')
                                  ],
                                )),
                            Checkbox(
                              value: data.value.teslimDurumu,
                              onChanged: (value) {},
                              checkColor: Colors.white,
                              activeColor: Colors.blue,
                            )
                          ],

                          // child: Obx(
                          //   () => CheckboxListTile(
                          //     title: Text(data.adiSoyadi.toString()),
                          // subtitle: Text(
                          //     '${data.adi}                                                       ${data.alisTarihi}'),
                          //     isThreeLine: true,
                          //     value: data.teslimDurumu.obs.value,
                          //     onChanged: null,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
