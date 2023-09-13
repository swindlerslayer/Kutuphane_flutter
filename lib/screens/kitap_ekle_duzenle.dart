import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
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
    List<String>? secilenbaslikyazi;
    var yazarcont = Get.put(YazarController());
    var yayinevicont = Get.put(YayineviController());
    var kitapturcont = Get.put(KitapTurController());

    gelenresim.value = gelenkitap?.resim;

    kitcont.getTekKitap(kullanici.kullaniciAdi.toString(),
        kullanici.parola.toString(), gelenkitap?.id);

    final kitapadicontroller =
        TextEditingController(text: gelenkitap?.adi ?? "");

    final barkodcontroller =
        TextEditingController(text: gelenkitap?.barkod.toString());

    final sayfasayisicontroller =
        TextEditingController(text: gelenkitap?.sayfaSayisi.toString());

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
                child: gelenkitap?.id == null
                    ? Container()
                    : IconButton(
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
                Obx(
                  () => gelenresim.value != null
                      ? Container(
                          height: 250,
                          width: 200,
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(255, 155, 155, 155),
                          ),
                          child: Image.memory(
                            base64Decode(gelenresim.value ?? ""),
                          ),
                        )
                      : Container(
                          height: 250,
                          width: 200,
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(255, 155, 155, 155),
                          ),
                          child: Center(
                              child: RichText(
                            text: const TextSpan(
                              text: 'Resim Yok',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: const Color.fromARGB(255, 0, 0, 0),
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
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
                                    if (photo == null) return;
                                    File? file = File(photo.path);
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
                                    if (image == null) return;
                                    File? file = File(image.path);
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
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.amber[50],
                    controller: kitapadicontroller,
                    decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.camera_alt_rounded),
                          onPressed: () async {
                            //Kameradan Ürün Adı Okuma işlemi bu buton içerisinde
                            final ImagePicker picker = ImagePicker();
                            final InputImage inputImage;

                            //Kameradan Fotoğraf çekiyor fotoğraf çekilmedi ise geri döndürüyor
                            //kameranın arka kamerasını kullanıyor
                            final XFile? photo = await picker.pickImage(
                                imageQuality: 50,
                                maxHeight: 1000,
                                maxWidth: 1000,
                                source: ImageSource.camera);
                            if (photo == null) return;

                            //inputImage değişkenine üstte çekilen fotoğrafın path değeri veriliyor
                            inputImage = InputImage.fromFilePath(photo.path);

                            //tanımasını istediğimiz alfabe tipini seçiyoruz
                            final textRecognizer = TextRecognizer(
                                script: TextRecognitionScript.latin);

                            //çektiğimiz fotoğrafın içerisindeki seçtiğimiz alfabedeki yazıları tanıyor
                            final RecognizedText recognizedText =
                                await textRecognizer.processImage(inputImage);

                            kitcont.checkboxValues.clear();

                            //checkboxValues listesine blokların sayısını kadar false değeri ekliyoruz
                            kitcont.checkboxValues.value = List.generate(
                                recognizedText.blocks.length, (index) => false);

                            // ignore: use_build_context_synchronously
                            final selectedString = await showDialog(
                              context: context,
                              builder: (context) => ListView(
                                children: [
                                  AlertDialog(
                                    content: Column(
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: recognizedText.blocks
                                              .map(
                                                (block) => SizedBox(
                                                  width: 350,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 235,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shadowColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            foregroundColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            backgroundColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    32,
                                                                    32,
                                                                    32), // Background color
                                                          ),
                                                          //Elevated butonu sonuna checkbox ekleyebileceğim
                                                          //bir widget ile değiştir
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(block
                                                                      .text),
                                                          child:
                                                              Text(block.text),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Obx(() =>
                                                            Checkbox(
                                                                value: kitcont
                                                                        .checkboxValues[
                                                                    //listedeki index değerini mapden gelen değere göre veriyorum
                                                                    recognizedText
                                                                        .blocks
                                                                        .indexOf(
                                                                            block)],
                                                                onChanged:
                                                                    (value) {
                                                                  kitcont.checkboxValues[recognizedText
                                                                          .blocks
                                                                          .indexOf(
                                                                              block)] =
                                                                      value!; //value true ise seçili false ise seçili değil

                                                                  //tiklenen checkbox indexindeki block.text'leri secilenbaslikyazi listesine ekliyoruz
                                                                  if (kitcont
                                                                          .checkboxValues[
                                                                      recognizedText
                                                                          .blocks
                                                                          .indexOf(
                                                                              block)]) {
                                                                    secilenbaslikyazi =
                                                                        [
                                                                      ...?secilenbaslikyazi,
                                                                      block.text
                                                                    ];
                                                                  } else {
                                                                    secilenbaslikyazi = secilenbaslikyazi!
                                                                        .where((element) =>
                                                                            element !=
                                                                            block.text)
                                                                        .toList();
                                                                  }
                                                                })),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              if (secilenbaslikyazi != null) {
                                                kitapadicontroller.clear();
                                                for (var i = 0;
                                                    i <
                                                        secilenbaslikyazi!
                                                            .length;
                                                    i++) {
                                                  kitapadicontroller.text +=
                                                      " ${secilenbaslikyazi![i]}";
                                                }
                                                Get.back();
                                                secilenbaslikyazi?.clear();
                                              }
                                            },
                                            child: const Text("Seç"))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (selectedString == null) return;
                            kitapadicontroller.text = selectedString;
                          },
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white)),
                        labelText: "Kitap İsmi"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: TextFormField(
                    cursorColor: Colors.amber[50],
                    controller: sayfasayisicontroller,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white)),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.greenAccent),
                        ),
                        labelText: "Sayfa Sayisi"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.amber[50],
                    controller: barkodcontroller,
                    decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.camera_alt_rounded),
                          onPressed: () async {
                            String barcodeScanRes;

                            barcodeScanRes =
                                await FlutterBarcodeScanner.scanBarcode(
                                    '#ff6666',
                                    'Cancel',
                                    true,
                                    ScanMode.BARCODE);
                            if (barcodeScanRes != "-1") {
                              barkodcontroller.text = barcodeScanRes;
                            }
                          },
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white)),
                        labelText: "Barkod"),
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
                            labelStyle: const TextStyle(color: Colors.white),
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
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
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
                            labelStyle: const TextStyle(color: Colors.white),
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
                                    ? yazarcontroller.value.text =
                                        x.adiSoyadi.toString()
                                    : null;
                              },
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
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
                    child: Obx(
                      () => TextField(
                        controller: kitapturcontroller.value,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(color: Colors.white),
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
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: const Color.fromARGB(255, 0, 0, 0),
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: const Color.fromARGB(
                            255, 32, 32, 32), // Background color
                      ),
                      onPressed: () async {
                        if (kitapadicontroller.text.isEmpty) {
                          Get.snackbar("Hata", "Kitap Adı Adı Boş Olamaz");
                          return;
                        } else if (barkodcontroller.text.isEmpty) {
                          Get.snackbar("Hata", "Barkod Boş Olamaz");
                          return;
                        } else if (sayfasayisicontroller.text.isEmpty) {
                          Get.snackbar("Hata", "Sayfa Sayısı Boş Olamaz");
                          return;
                        } else if (yayinevicontroller.value.text.isEmpty) {
                          Get.snackbar("Hata", "Yayınevi Boş Olamaz");
                          return;
                        } else if (yazarcontroller.value.text.isEmpty) {
                          Get.snackbar("Hata", "Yazar Boş Olamaz");
                          return;
                        } else if (kitapturcontroller.value.text.isEmpty) {
                          Get.snackbar("Hata", "Kitap Türü Boş Olamaz");
                          return;
                        } else {
                          Kitap k = Kitap();
                          k.id = kitapid;
                          k.adi = kitapadicontroller.text;
                          k.sayfaSayisi = int.parse(sayfasayisicontroller.text);
                          k.barkod = barkodcontroller.text;
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
