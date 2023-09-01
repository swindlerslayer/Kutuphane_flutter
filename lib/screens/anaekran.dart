import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/anasayfa_controller.dart';
import 'package:kutuphane_mobil_d/Model/OgrenciKitap/ogrenci_kitap.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Anasayfa'),
      ),
      body: BodyWidget(kullanici: kullanici),
    );
  }
}

class BodyWidget extends StatelessWidget {
  BodyWidget({super.key, required this.kullanici});
  final cont = Get.put(AnasayfaController());
  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var dd = await Get.put(AnasayfaController()).getOgrenciKitap(
          kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
      Get.put(AnasayfaController()).kitapogrenci = dd ?? [];
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
            () => ListView.builder(
                shrinkWrap: true,
                itemCount: cont.kitapogrenci.length,
                itemBuilder: (context, index) {
                  var data = cont.kitapogrenci[index];

                  return FocusedMenuHolder(
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
                              data.id); // data.id
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
                          ok.id = data.id;
                          data.teslimDurumu = true;

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
                              data.id); // data.id
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
                          ok.id = data.id;
                          data.teslimDurumu = false;

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
                                          TextSpan(text: '${data.adiSoyadi} '),
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
                                          TextSpan(text: '${data.adi}'),
                                        ],
                                      ),
                                    ),
                                   
                                    Text(
                                        'Okul Numarası: ${data.okulNo.toString()}'),
                                    //  Text('${data.alisTarihi}'),
                                    // Text(
                                    //     '${DateFormat.yMd().parse(data.alisTarihi!, false)}      ')
                                  ],
                                )),
                            Checkbox(
                              value: data.teslimDurumu,
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
                  );
                }),
          )
        ],
      ),
    );
  }
}
