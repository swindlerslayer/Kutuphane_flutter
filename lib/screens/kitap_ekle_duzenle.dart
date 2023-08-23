import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kitap/kitap.dart';
import 'package:kutuphane_mobil_d/Model/KitapTur/kitapturuliste.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/Model/Yayinevi/yayineviliste.dart';
import 'package:kutuphane_mobil_d/Model/Yazar/yazarliste.dart';

import '../Controllers/kitapturu_controller.dart';
import '../Controllers/yazar_controller.dart';

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
  final kitcont = Get.put(KitapController());

  final KullaniciGiris kullanici;
  final String giristuru;

  final Kitap? gelenkitap;
  final selectedYazarListe = Rxn<ListeYazar>();
  final selectedKitapTurListe = Rxn<KitapTurListe>();
  final selectedYayineviListe = Rxn<YayineviListe>();
  final gelenresim = Rxn<String>();
  @override
  Widget build(BuildContext context) {
    gelenresim.value = gelenkitap?.resim;
    kitcont.getTekKitap(kullanici.kullaniciAdi.toString(),
        kullanici.parola.toString(), gelenkitap?.id);
    final kullaniciadicontroller =
        TextEditingController(text: gelenkitap?.adi ?? "");
    final kitapadicontroller =
        TextEditingController(text: gelenkitap?.sayfaSayisi.toString());
    final sayfasayisicontroller =
        TextEditingController(text: gelenkitap?.barkod.toString());
    var datayazar = contyazzar.yazarliste;
    var datayayinevi = contyayinevi.yayineviliste;
    var datakitapturu = contkitapturu.kitapturList;
    KitapTurListe? selectedkitapturuilk;
    YayineviListe? selectedyeyineviilk;
    ListeYazar? selectedyazarilk;
    int? kitapid = gelenkitap?.id ?? 0;
    if (gelenkitap != null) {
      selectedkitapturuilk =
          datakitapturu.firstWhere((kt) => kt.id == gelenkitap?.kitapTurId);
      selectedyeyineviilk =
          datayayinevi.firstWhere((ye) => ye.id == gelenkitap?.yayinEviId);
      selectedyazarilk =
          datayazar.firstWhere((y) => y.id == gelenkitap?.yazarId);
      selectedKitapTurListe.value = selectedkitapturuilk;
      selectedYayineviListe.value = selectedyeyineviilk;
      selectedYazarListe.value = selectedyazarilk;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 252, 252)),
          onPressed: () async {
            Get.back();

            //final cont = Get.put(KitapController());

            // cont.sayfakitapList?.clear();
            // print(cont.totalPageCount);
            // var dd = await Get.put(KitapController()).getKitap(
            //     kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
            // Get.put(KitapController()).sayfakitapList = dd;
            // Get.to(KitapSayfasi(kullanici: kullanici));
          },
        ),
        title: Text("Kitap $giristuru Sayfası"),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            Obx(
              () => gelenresim.value != null
                  ? Image.memory(base64Decode(gelenresim.value!),
                      width: 200, height: 200)
                  : const Icon(Icons.signal_cellular_no_sim),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Center(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: const Color.fromARGB(255, 0, 0, 0),
                    foregroundColor: const Color.fromARGB(255, 1, 153, 255),
                    backgroundColor: const Color.fromARGB(
                        255, 32, 32, 32), // Background color
                  ),
                  onPressed: () async {
                    bool? isCamera = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? photo = await picker.pickImage(
                                    source: ImageSource.camera);
                                Image.file(photo as File);
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop(true);
                              },
                              child: const Text("Kamera"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();

                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);

                                File? file = File(image!.path);
                                gelenresim.value =
                                    base64.encode(await file.readAsBytes());
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop(true);
                              },
                              child: const Text("Galeri "),
                            ),
                          ],
                        ),
                      ),
                    );

                    if (isCamera == null) return;
                  },
                  child: Text("Resim ${giristuru.toString()}"),
                ))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Center(
                child: Obx(
                  () => DropdownButton<KitapTurListe>(
                    onChanged: (KitapTurListe? value) {
                      selectedKitapTurListe.value = value;
                    },
                    value: selectedKitapTurListe.value,
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Center(
                child: Obx(
                  () => DropdownButton<ListeYazar>(
                    onChanged: (ListeYazar? value) {
                      selectedYazarListe.value = value;
                    },
                    value: selectedYazarListe.value,
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Center(
                child: Obx(
                  () => DropdownButton<YayineviListe>(
                    onChanged: (YayineviListe? value) {
                      selectedYayineviListe.value = value;
                    },
                    value: selectedYayineviListe.value,
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: const Color.fromARGB(255, 0, 0, 0),
                    foregroundColor: const Color.fromARGB(255, 1, 153, 255),
                    backgroundColor: const Color.fromARGB(
                        255, 32, 32, 32), // Background color
                  ),
                  onPressed: () async {
                    Kitap k = Kitap();
                    k.id = kitapid;
                    k.adi = kullaniciadicontroller.text;
                    k.sayfaSayisi = int.parse(kitapadicontroller.text);
                    k.barkod = int.parse(sayfasayisicontroller.text);
                    k.yayinEviId = selectedYayineviListe.value?.id ??
                        selectedyeyineviilk?.id;
                    k.yazarId =
                        selectedYazarListe.value?.id ?? selectedyazarilk?.id;
                    k.kitapTurId = selectedKitapTurListe.value?.id ??
                        selectedkitapturuilk?.id;
                    k.resim = gelenresim.value;

                    var kaydetGuncelleKontrol = await KitapController()
                        .ekleguncelleKitap(kullanici.kullaniciAdi!.obs,
                            kullanici.parola!.obs, k);

                    if (kaydetGuncelleKontrol == "Eklendi") {
                      Get.defaultDialog(
                          title: "Kitap Eklendi",
                          middleText: "",
                          backgroundColor:
                              const Color.fromARGB(255, 141, 141, 141));
                    } else if (kaydetGuncelleKontrol == "Güncellendi") {
                      Get.defaultDialog(
                          title: "Kitap Güncellendi",
                          middleText: "",
                          backgroundColor:
                              const Color.fromARGB(255, 141, 141, 141));
                    }
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
