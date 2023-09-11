import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/anasayfa_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kitap/kitap.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/Model/Ogrenci/ogrenci.dart';
import 'package:kutuphane_mobil_d/Model/Yayinevi/yayinevi.dart';
import 'package:kutuphane_mobil_d/screens/kitapekran.dart';
import 'package:kutuphane_mobil_d/screens/ogrenciekran.dart';
import 'package:kutuphane_mobil_d/screens/yayineviekran.dart';

class AnaekranDrawer extends StatelessWidget {
  AnaekranDrawer({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;
  final sayfasayimintextcontroller = TextEditingController();
  final sayfasayimaxtextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cont = Get.put(AnasayfaController());
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ExpansionTile(
            title: const Text("Kitap"),
            children: [
              ListTile(
                trailing: const Icon(Icons.add),
                title: RichText(
                  text: const TextSpan(
                    text: "Kitap Ekle",
                  ),
                ),
                onTap: () async {
                  var x = await Get.to<Kitap>(() => KitapSayfasi(
                        kullanici: kullanici,
                        secim: 2,
                        toplusec: true,
                      ));
                  if (x != null) {
                    cont.kitaplar?.add(x);
                    cont.anasayfafiltre.kitapid ??= [];
                    cont.anasayfafiltre.obs.value.kitapid?.add(x.id!);
                    print("kitapid: ${cont.anasayfafiltre.obs.value.kitapid}");
                  }
                },
              ),
              Obx(
                () => SizedBox(
                  height: cont.kitaplar!.length * 48,
                  child: ListView.builder(
                    itemCount: cont.kitaplar?.isEmpty == true
                        ? 0
                        : cont.kitaplar?.length,
                    itemBuilder: (BuildContext context, i) {
                      return ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            cont.kitaplar?.removeAt(i);
                            cont.anasayfafiltre.obs.value.kitapid?.removeAt(i);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color.fromARGB(255, 122, 75, 72),
                          ),
                        ),
                        title: Text(cont.kitaplar?[i].adi ?? ""),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("Öğrenci"),
            children: [
              ListTile(
                trailing: const Icon(Icons.add),
                title: RichText(
                  text: const TextSpan(
                    text: "Öğrenci Ekle",
                  ),
                ),
                onTap: () async {
                  var x = await Get.to<Ogrenci>(() => OgrenciSayfasi(
                        kullanici: kullanici,
                        secim: 2,
                        toplusec: true,
                      ));
                  if (x != null) {
                    cont.ogrenciler?.add(x);
                    cont.anasayfafiltre.ogrenciid ??= [];
                    cont.anasayfafiltre.ogrenciid?.add(x.id!);
                    print(
                        "kitapid: ${cont.anasayfafiltre.obs.value.ogrenciid}");
                  }
                },
              ),
              Obx(
                () => SizedBox(
                  height: cont.ogrenciler!.length * 48,
                  child: ListView.builder(
                    itemCount: cont.ogrenciler?.isEmpty == true
                        ? 0
                        : cont.ogrenciler?.length,
                    itemBuilder: (BuildContext context, i) {
                      return ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            cont.ogrenciler?.removeAt(i);
                            cont.anasayfafiltre.obs.value.ogrenciid
                                ?.removeAt(i);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color.fromARGB(255, 122, 75, 72),
                          ),
                        ),
                        title: Text(cont.ogrenciler?[i].adiSoyadi ?? ""),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("Yayınevi"),
            children: [
              ListTile(
                trailing: const Icon(Icons.add),
                title: RichText(
                  text: const TextSpan(
                    text: "Yayınevi Ekle",
                  ),
                ),
                onTap: () async {
                  var x = await Get.to<Yayinevi>(
                    () => YayineviSayfasi(
                      kullanici: kullanici,
                      secim: 2,
                      toplusec: true,
                    ),
                  );

                  if (x != null) {
                    cont.anasayfafiltre.obs.value.yayineviid ??=
                        []; // kitapturid null ise boş bir liste oluştur
                    cont.yayinevleri?.add(x);
                    cont.anasayfafiltre.obs.value.yayineviid!.add(x.id!);
                    print(
                        "kitapid: ${cont.anasayfafiltre.obs.value.yayineviid}");
                  }
                },
              ),
              Obx(
                () => SizedBox(
                  height: cont.yayinevleri!.length * 48,
                  child: ListView.builder(
                    itemCount: cont.yayinevleri?.isEmpty == true
                        ? 0
                        : cont.yayinevleri?.length,
                    itemBuilder: (BuildContext context, i) {
                      return ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            cont.yayinevleri?.removeAt(i);
                            cont.anasayfafiltre.obs.value.yayineviid
                                ?.removeAt(i);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color.fromARGB(255, 122, 75, 72),
                          ),
                        ),
                        title: Text(cont.yayinevleri?[i].adi ?? ""),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          ListTile(
            onLongPress: () {},
            trailing: const Icon(
              Icons.check_circle,
            ),
            tileColor: const Color.fromARGB(246, 115, 115, 115),

            //  leading: const Icon(Icons.abc),
            title: Align(
              alignment: const Alignment(0.2, 0),
              child: RichText(
                text: const TextSpan(
                    text: "Filtreyi uygula",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
            onTap: () {
              MetodModel z = MetodModel();
              z.kalinanSayfa = cont.simdikisayfa;
              z.kullaniciAdi = kullanici.kullaniciAdi.toString();
              z.parola = kullanici.parola.toString();
              z.lkSayfa = true;
              z.filtreanasayfa = cont.anasayfafiltre;

              Get.put(AnasayfaController()).getSayfaFiltreOgrenciKitap(z);
            },
          ),
          SizedBox(
            width: 50,
            child: ListTile(
              onTap: () {
                cont.anasayfafiltre.obs.value.kitapid = null;
                cont.anasayfafiltre.obs.value.ogrenciid = null;
                cont.anasayfafiltre.obs.value.yayineviid = null;
                cont.yayinevleri?.clear();
                cont.ogrenciler?.clear();
                cont.kitaplar?.clear();

                MetodModel z = MetodModel();
                z.kalinanSayfa = cont.simdikisayfa;
                z.kullaniciAdi = kullanici.kullaniciAdi.toString();
                z.parola = kullanici.parola.toString();
                z.lkSayfa = true;
                Get.put(AnasayfaController()).getSayfaFiltreOgrenciKitap(z);
              },
              title: const Text("Filtreyi Temizle"),
              trailing: const Icon(Icons.close),
              tileColor: const Color.fromARGB(246, 107, 67, 67),
            ),
          ),
        ],
      ),
    );
  }
}
