import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/Model/Yayinevi/yayinevi.dart';
import 'package:kutuphane_mobil_d/Model/Yazar/yazar.dart';
import 'package:kutuphane_mobil_d/screens/kitapturuekran.dart';
import 'package:kutuphane_mobil_d/screens/yayineviekran.dart';
import 'package:kutuphane_mobil_d/screens/yazarekran.dart';

import '../Model/KitapTur/kitapturu.dart';

class KitapDrawer extends StatelessWidget {
  KitapDrawer({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;
  final sayfasayimintextcontroller = TextEditingController();
  final sayfasayimaxtextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // DRAWER İÇERİSİNDE LİSTVİEW BUİLDER OLUŞTURABİİLMEK İÇİN BU ŞEKİLDE SABİT YÜKSEKLİK VERMELİYİZ
    var cont = Get.put(KitapController());
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ExpansionTile(
            title: const Text("Yazar"),
            children: [
              ListTile(
                trailing: const Icon(Icons.add),
                title: RichText(
                  text: const TextSpan(
                    text: "Yazar Ekle",
                  ),
                ),
                onTap: () async {
                  var x = await Get.to<Yazar>(() => YazarSayfasi(
                        kullanici: kullanici,
                        secim: 2,
                        toplusec: true,
                      ));
                  if (x != null) {
                    cont.yazarlar?.add(x);
                    cont.kitapfiltre.yazarid ??= [];
                    cont.kitapfiltre.obs.value.yazarid?.add(x.id!);
                  }
                },
              ),
              Obx(
                () => SizedBox(
                  height: cont.yazarlar!.length * 48,
                  child: ListView.builder(
                    itemCount: cont.yazarlar?.isEmpty == true
                        ? 0
                        : cont.yazarlar?.length,
                    itemBuilder: (BuildContext context, i) {
                      return ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              cont.yazarlar?.removeAt(i);
                              cont.kitapfiltre.obs.value.yazarid?.removeAt(i);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Color.fromARGB(255, 122, 75, 72),
                            )),
                        title: Text(cont.yazarlar?[i].adiSoyadi ?? ""),
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
                  var x = await Get.to<Yayinevi>(() => YayineviSayfasi(
                        kullanici: kullanici,
                        secim: 2,
                        toplusec: true,
                      ));
                  if (x != null) {
                    cont.yayinevleri?.add(x);
                    cont.kitapfiltre.yayineviid ??= [];
                    cont.kitapfiltre.obs.value.yayineviid?.add(x.id!);
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
                              cont.kitapfiltre.obs.value.yayineviid
                                  ?.removeAt(i);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Color.fromARGB(255, 122, 75, 72),
                            )),
                        title: Text(cont.yayinevleri?[i].adi ?? ""),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("Kitap Türü"),
            children: [
              ListTile(
                trailing: const Icon(Icons.add),
                title: RichText(
                  text: const TextSpan(
                    text: "Kitap Türü Ekle",
                  ),
                ),
                onTap: () async {
                  var x = await Get.to<KitapTur>(
                    () => KitapTurSayfasi(
                      kullanici: kullanici,
                      secim: 2,
                    ),
                  );

                  if (x != null) {
                    cont.kitapfiltre.kitapturid ??=
                        []; // kitapturid null ise boş bir liste oluştur
                    cont.kitapturleri?.add(x);
                    cont.kitapfiltre.kitapturid!.add(x.id!);
                  }
                },
              ),
              Obx(
                () => SizedBox(
                  height: cont.kitapturleri!.length * 48,
                  child: ListView.builder(
                    itemCount: cont.kitapturleri?.isEmpty == true
                        ? 0
                        : cont.kitapturleri?.length,
                    itemBuilder: (BuildContext context, i) {
                      return ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              cont.kitapturleri?.removeAt(i);
                              cont.kitapfiltre.obs.value.kitapturid
                                  ?.removeAt(i);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Color.fromARGB(255, 122, 75, 72),
                            )),
                        title: Text(cont.kitapturleri?[i].adi ?? ""),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("Sayfa Sayısı"),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: sayfasayimintextcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Minimum Sayfa Sayısı"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: sayfasayimaxtextcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Maksimum Sayfa Sayısı"),
                ),
              ),
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
              final cont = Get.put(KitapController());

              MetodModel z = MetodModel();
              z.kalinanSayfa = cont.simdikisayfa;
              z.kullaniciAdi = kullanici.kullaniciAdi.toString();
              z.parola = kullanici.parola.toString();
              z.lkSayfa = true;
              cont.kitapfiltre.maxsayfasayisi =
                  int.tryParse(sayfasayimaxtextcontroller.text);
              cont.kitapfiltre.minsayfasayisi =
                  int.tryParse(sayfasayimintextcontroller.text);

              z.filtre = cont.kitapfiltre;

              Get.put(KitapController()).getSayfaFiltreKitap(z);
            },
          ),
          SizedBox(
            width: 50,
            child: ListTile(
              onTap: () {
                cont.kitapfiltre.kitapturid = null;
                cont.kitapfiltre.yazarid = null;
                cont.kitapfiltre.maxsayfasayisi = null;
                cont.kitapfiltre.minsayfasayisi = null;
                cont.yazarlar?.clear();
                cont.yayinevleri?.clear();
                cont.kitapturleri?.clear();

                cont.kitapfiltre.yayineviid = null;
                sayfasayimaxtextcontroller.text = "";
                sayfasayimintextcontroller.text = "";

                MetodModel z = MetodModel();
                z.kalinanSayfa = cont.simdikisayfa;
                z.kullaniciAdi = kullanici.kullaniciAdi.toString();
                z.parola = kullanici.parola.toString();
                z.lkSayfa = true;
                cont.kitapfiltre.maxsayfasayisi =
                    int.tryParse(sayfasayimaxtextcontroller.text);
                cont.kitapfiltre.minsayfasayisi =
                    int.tryParse(sayfasayimintextcontroller.text);

                z.filtre = cont.kitapfiltre;

                Get.put(KitapController()).getSayfaFiltreKitap(z);
              },
              title: const Text("Filtreyi Temizle"),
              trailing: const Icon(Icons.close),
              tileColor: const Color.fromARGB(246, 107, 67, 67),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //         child: ListTile(
          //       onTap: () {},
          //       title: const Text("Filtre Yok"),
          //       trailing: const Icon(Icons.close),
          //       tileColor: const Color.fromARGB(246, 107, 67, 67),
          //     )),
          //     SizedBox(
          //       child: ListTile(
          //         onTap: () {},
          //         title: const Text("Filtre Yok"),
          //         trailing: const Icon(Icons.close),
          //         tileColor: const Color.fromARGB(246, 107, 67, 67),
          //       ),
          //     ),
          //   ],
          // )

        ],
      ),
    );
  }
}
