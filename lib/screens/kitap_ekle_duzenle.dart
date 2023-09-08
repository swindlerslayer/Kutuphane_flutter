import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';

import 'package:kutuphane_mobil_d/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kitap/kitap.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/kitapturuekran.dart';
import 'package:kutuphane_mobil_d/screens/resimekran.dart';
import 'package:kutuphane_mobil_d/screens/yayineviekran.dart';
import 'package:kutuphane_mobil_d/screens/yazarekran.dart';

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

  final gelenresim = Rxn<String>();
  @override
  Widget build(BuildContext context) {
    var yazarcont = Get.put(YazarController());
    var yayinevicont = Get.put(YayineviController());
    var kitapturcont = Get.put(KitapTurController());

    gelenresim.value = gelenkitap?.resim;

    kitcont.getTekKitap(kullanici.kullaniciAdi.toString(),
        kullanici.parola.toString(), gelenkitap?.id);

    final kullaniciadicontroller =
        TextEditingController(text: gelenkitap?.adi ?? "");

    final kitapadicontroller =
        TextEditingController(text: gelenkitap?.sayfaSayisi.toString());

    final sayfasayisicontroller =
        TextEditingController(text: gelenkitap?.barkod.toString());

    final yayinevicontroller =
        TextEditingController(text: gelenkitap?.adi1 ?? "").obs;

    final yazarcontroller =
        TextEditingController(text: gelenkitap?.adisoyadi ?? "").obs;

    final kitapturcontroller =
        TextEditingController(text: gelenkitap?.adi2 ?? "").obs;

    //var datayazar = contyazzar.yazarliste;

    // ListeYazar? selectedyazarilk;
    int? kitapid = gelenkitap?.id ?? 0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Kitap $giristuru "),
        leading: GestureDetector(
          onTap: () {},
          child: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 255, 252, 252)),
            onPressed: () async {
              Get.back();
            },
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: IconButton(
                  icon: const Icon(Icons.filter),
                  onPressed: () {
                    Get.to(ResimSayfasi(
                      kullanici: kullanici,
                      gelenkitapid: gelenkitap!.id ?? 0,
                    ));
                  },
                ),
              )),
        ],
      ),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 44, 44, 44),
                ],
              ),
            ),
            child: Column(
              children: [
                Obx(() => gelenresim.value != null
                    ? Container(
                        height: 250,
                        width: 200,
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 155, 155, 155),
                        ),
                        child:
                            Image.memory(base64Decode(gelenresim.value ?? "")))
                    : Container(
                        height: 250,
                        width: 200,
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 155, 155, 155),
                        ),
                        child: const Text("RESİM YOK"),
                      )),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                                        imageQuality: 50,
                                        maxHeight: 1000,
                                        maxWidth: 1000,
                                        source: ImageSource.camera);
                                    File? file = File(photo!.path);
                                    gelenresim.value =
                                        base64.encode(await file.readAsBytes());
                                    Get.back();
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
                                        imageQuality: 1,
                                        maxHeight: 100,
                                        maxWidth: 100,
                                        source: ImageSource.gallery);

                                    File? file = File(image!.path);
                                    gelenresim.value =
                                        base64.encode(await file.readAsBytes());
                                    Get.back();
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: TextFormField(
                    controller: kitapadicontroller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Sayfa Sayisi"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen Sayfa Sayisini Giriniz';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                SizedBox(
                  width: 200,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Obx(() => TextField(
                          controller: yayinevicontroller.value,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Kitabın Yayınevi",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add_box),
                              onPressed: () async {
                                var x = await Get.to(() => YayineviSayfasi(
                                      kullanici: kullanici,
                                      secim: 1,
                                      kitapID: gelenkitap?.id,
                                      toplusec: false,
                                    ));
                                x != null
                                    ? yayinevicontroller.value.text = x
                                    : null;
                              },
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 164, 164, 164)),
                            ),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Obx(() => TextField(
                          controller: yazarcontroller.value,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Kitabın Yazarı",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add_box),
                              onPressed: () async {
                                var x = await Get.to(() => YazarSayfasi(
                                      kullanici: kullanici,
                                      secim: 1,
                                      kitapID: gelenkitap?.id,
                                      toplusec: false,
                                    ));
                                x != null
                                    ? yazarcontroller.value.text = x
                                    : null;
                              },
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 164, 164, 164)),
                            ),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Obx(() => TextField(
                          controller: kitapturcontroller.value,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Kitap Türü",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add_box),
                              onPressed: () async {
                                var x = await Get.to(() => KitapTurSayfasi(
                                      kullanici: kullanici,
                                      secim: 1,
                                      kitapID: gelenkitap?.id,
                                    ));
                                x != null
                                    ? kitapturcontroller.value.text = x
                                    : null;
                              },
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 164, 164, 164)),
                            ),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
                        k.yayinEviId = yayinevicont.gelenyayinevi.id;
                        k.yazarId = yazarcont.gelenyazar.id;
                        k.kitapTurId = kitapturcont.gelenkitaptur.id;
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
                        } else if (kaydetGuncelleKontrol == k.id.toString()) {
                          var tekkitap = await KitapController().getTekKitap(
                              kullanici.kullaniciAdi.toString(),
                              kullanici.parola.toString(),
                              k.id);
                          Get.back<Kitap>(result: tekkitap);
                        } else {
                          Get.defaultDialog(
                              title: "?????????",
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
        ],
      ),
    );
  }
}
