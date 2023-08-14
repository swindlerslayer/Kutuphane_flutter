import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil_d/Degiskenler/kitap.dart';
import 'package:kutuphane_mobil_d/Degiskenler/kitapturu.dart';
import 'package:kutuphane_mobil_d/Degiskenler/kullanici.dart';
import 'package:kutuphane_mobil_d/Degiskenler/yayinevi.dart';
import 'package:kutuphane_mobil_d/Degiskenler/yazar.dart';

import '../Controllers/kitapturu_controller.dart';
import '../Controllers/yazar_controller.dart';
import 'kitapekran.dart';

class KitapEkleDuzenleSayfasi extends StatelessWidget {
  KitapEkleDuzenleSayfasi(
      {Key? key,
      required this.kullanici,
      required this.giristuru,
      this.gelenkitap})
      : super(key: key);
  final contyazzar = Get.put(YazarController());
  final contkitapturu = Get.put(KitapTurController());
  final contyayinevi = Get.put(YayineviController());

  final KullaniciGiris kullanici;
  final String giristuru;
  final Kitap? gelenkitap;
  final selectedYazarListe = Rxn<ListeYazar>();
  final selectedKitapTurListe = Rxn<KitapTurListe>();
  final selectedYayineviListe = Rxn<YayineviListe>();

  @override
  Widget build(BuildContext context) {
    final kullaniciadicontroller =
        TextEditingController(text: gelenkitap?.adi ?? "");
    final kitapadicontroller =
        TextEditingController(text: gelenkitap?.sayfaSayisi.toString());
    final sayfasayisicontroller =
        TextEditingController(text: gelenkitap?.barkod.toString());
    var datayazar = contyazzar.yazarliste;
    var datayayinevi = contyayinevi.yayineviliste;
    var datakitapturu = contkitapturu.kitapturList;
    KitapTurListe? selectekkitapturuilk;
    YayineviListe? selectedyeyineviilk;
    ListeYazar? selectedyazarilk;
    if (gelenkitap != null) {
      selectekkitapturuilk =
          datakitapturu.firstWhere((kt) => kt.id == gelenkitap?.kitapTurId);
      selectedyeyineviilk =
          datayayinevi.firstWhere((ye) => ye.id == gelenkitap?.yayinEviId);
      selectedyazarilk =
          datayazar.firstWhere((y) => y.id == gelenkitap?.yazarId);
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 252, 252)),
          onPressed: () async {
            var dd = await Get.put(KitapController()).getKitap(
                kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
            Get.put(KitapController()).kitapList = dd ?? [];
            Get.back();

            Get.to(KitapSayfasi(kullanici: kullanici));
          },
        ),
        title: Text("Kitap $giristuru Sayfası"),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: kullaniciadicontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "kitap adı"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Kitap Adini Giriniz';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: kitapadicontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Sayfa Sayisi"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Sayfa Sayisini Giriniz';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: sayfasayisicontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Barkod"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Sayfa Sayisini Giriniz';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Center(
                child: Obx(
                  () => DropdownButton<KitapTurListe>(
                    onChanged: (KitapTurListe? value) {
                      selectedKitapTurListe.value = value;
                    },
                    value: selectekkitapturuilk ?? selectedKitapTurListe.value,
                    items: datakitapturu.map(
                      (KitapTurListe items) {
                        return DropdownMenuItem<KitapTurListe>(
                          value: items,
                          child: Text(items.adi.toString()),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Center(
                child: Obx(
                  () => DropdownButton<ListeYazar>(
                    onChanged: (ListeYazar? value) {
                      selectedYazarListe.value = value;
                    },
                    value: selectedyazarilk ?? selectedYazarListe.value,
                    items: datayazar.map(
                      (ListeYazar items) {
                        return DropdownMenuItem<ListeYazar>(
                          value: items,
                          child: Text(items.adiSoyadi.toString()),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Center(
                child: Obx(
                  () => DropdownButton<YayineviListe>(
                    onChanged: (YayineviListe? value) {
                      selectedYayineviListe.value = value;
                    },
                    value: selectedyeyineviilk ?? selectedYayineviListe.value,
                    items: datayayinevi.map(
                      (YayineviListe items) {
                        return DropdownMenuItem<YayineviListe>(
                          value: items,
                          child: Text(items.adi.toString()),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // final k = Kitap();
                    Kitap k = Kitap();
                    k.adi = kullaniciadicontroller.text;
                    k.sayfaSayisi = int.parse(kitapadicontroller.text);
                    k.barkod = int.parse(sayfasayisicontroller.text);

                    KitapController().ekleguncelleKitap(
                        kullanici.kullaniciAdi, kullanici.parola, k);
                  },
                  child: Text(giristuru.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
