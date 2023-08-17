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
  final deger = Rxn<bool>();

  @override
  Widget build(BuildContext context) {
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
          ListView.builder(
              shrinkWrap: true,
              itemCount: cont.kitapogrenci.length,
              itemBuilder: (context, index) {
                var data = cont.kitapogrenci[index];
                deger.value = data.teslimDurumu;

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
                                kullanici.kullaniciAdi.value,
                                kullanici.parola.value,
                                data.id); // data.id
                            var ogrencikitap = await gelenok;

                            OgrenciKitap ok = OgrenciKitap();

                            ok.teslimTarihi = DateTime.now().toString();
                            ok.teslimDurumu = true;
                            ok.ogrenciId = ogrencikitap?.ogrenciId;
                            ok.kitapId = ogrencikitap?.kitapId;
                            ok.kullancId = ogrencikitap?.kullancId;
                            ok.kayitTarihi = ogrencikitap?.kayitTarihi;
                            ok.alisTarihi = ogrencikitap?.alisTarihi;
                            ok.id = data.id;
                            deger.value = true;
                            data.teslimDurumu = true;

                            var kaydetGuncelleKontrol =
                                await AnasayfaController()
                                    .ekleguncelleOgrenciKitap(
                                        kullanici.kullaniciAdi,
                                        kullanici.parola,
                                        ok);
                            if (kaydetGuncelleKontrol == "Güncellendi") {
                              Get.defaultDialog(
                                  title: "Güncellendi",
                                  middleText: "",
                                  backgroundColor:
                                      const Color.fromARGB(255, 141, 141, 141));
                            }
                          }),
                      FocusedMenuItem(
                          backgroundColor:
                              const Color.fromARGB(255, 110, 57, 57),
                          title: const Text("Teslim Alınmadı"),
                          trailingIcon: const Icon(Icons.edit),
                          onPressed: () async {
                            var gelenok = cont.getTekOgrenciKitap(
                                kullanici.kullaniciAdi.value,
                                kullanici.parola.value,
                                data.id); // data.id
                            var ogrencikitap = await gelenok;

                            OgrenciKitap ok = OgrenciKitap();

                            ok.teslimDurumu = false;
                            ok.ogrenciId = ogrencikitap?.ogrenciId;
                            ok.kitapId = ogrencikitap?.kitapId;
                            ok.kullancId = ogrencikitap?.kullancId;
                            ok.kayitTarihi = ogrencikitap?.kayitTarihi;
                            ok.alisTarihi = ogrencikitap?.alisTarihi;
                            ok.degisiklikTarihi = DateTime.now().toString();
                            ok.id = data.id;
                            deger.value = false;
                            data.teslimDurumu = false;
                            var kaydetGuncelleKontrol =
                                await AnasayfaController()
                                    .ekleguncelleOgrenciKitap(
                                        kullanici.kullaniciAdi,
                                        kullanici.parola,
                                        ok);
                            if (kaydetGuncelleKontrol == "Güncellendi") {
                              Get.defaultDialog(
                                  title: "Güncellendi",
                                  middleText: "",
                                  backgroundColor:
                                      const Color.fromARGB(255, 141, 141, 141));
                            }
                          })
                    ],
                    child: Obx(() => Card(
                            child: CheckboxListTile(
                          title: Text(data.adiSoyadi.toString()),
                          subtitle: Text(
                              '${data.adi}                                                       ${data.alisTarihi}'),
                          isThreeLine: true,
                          onChanged: (bool? value) {},
                          value: data.teslimDurumu,
                        ))));
              }),
        ],
      ),
    );
  }
}
