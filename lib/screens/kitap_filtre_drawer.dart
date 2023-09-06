import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Model/Filtre/kitapfiltre.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
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
    // Container(
    //     height: double.maxFinite,                // DRAWER İÇERİSİNDE LİSTVİEW BUİLDER OLUŞTURABİİLMEK İÇİN BU ŞEKİLDE SABİT YÜKSEKLİK VERMELİYİZ
    //     child: ListView.builder(itemBuilder: itemBuilder));
    var cont = Get.put(Kitapfiltrecontroller());
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
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
                  var x = await Get.to(() => YazarSayfasi(
                        kullanici: kullanici,
                        secim: 2,
                      ));
                  x != null ? cont.yazarlar?.add(x) : 0;
                },
              ),
              Obx(() => SizedBox(
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
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Color.fromARGB(255, 122, 75, 72),
                              )),
                          title: Text(cont.yazarlar?[i].adiSoyadi ?? ""),
                        );
                      })))
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
                  var x = await Get.to(() => YayineviSayfasi(
                        kullanici: kullanici,
                        secim: 2,
                      ));
                  x != null ? cont.yayinevleri?.add(x) : 0;

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
                  var x = await Get.to(() => KitapTurSayfasi(
                        kullanici: kullanici,
                        secim: 2,
                      ));
                  x != null ? cont.kitapturleri?.add(x) : 0;
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
            trailing: const Icon(
              Icons.check_circle,
            ),
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class Kitapfiltrecontroller extends GetxController {
  final _yazarlar = <Yazar>[].obs;
  List<Yazar>? get yazarlar => _yazarlar;
  set yazarlar(List<Yazar>? value) => _yazarlar;

  final _yayinevleri = <Yayinevi>[].obs;
  List<Yayinevi>? get yayinevleri => _yayinevleri;
  set yayinevleri(List<Yayinevi>? value) => _yayinevleri;

  final _kitapturleri = <KitapTur>[].obs;
  List<KitapTur>? get kitapturleri => _kitapturleri;
  set kitapturleri(List<KitapTur>? value) => _kitapturleri;

  final _kitapfiltre = <KitapFiltre>[].obs;
  List<KitapFiltre>? get kitapfiltre => _kitapfiltre;
  set kitapfiltre(List<KitapFiltre>? value) => _kitapfiltre;
  // Filtre Model == Yazarid = list int
  //                 Yayineviid = list int
  //                  Kitapturid = list  int
  //                  MinSayfa = int
  //                  MaxSayfa = int
}
