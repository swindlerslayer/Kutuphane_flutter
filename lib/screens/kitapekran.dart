import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kitap/kitap.dart';
import 'package:kutuphane_mobil_d/Model/MetodModel/metodmodel.dart';
import 'package:kutuphane_mobil_d/screens/kitap_filtre_drawer.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/Controllers/kitapturu_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/yazar_controller.dart';
import 'package:image_picker/image_picker.dart';
//import imagee class from package from C:\Users\deret\AppData\Local\Pub\Cache\hosted\pub.dev\image-3.3.0\lib\src\image.dart this file path
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:image/image.dart' as img;
import 'kitap_ekle_duzenle.dart';

class KitapSayfasi extends StatelessWidget {
  KitapSayfasi(
      {Key? key,
      required this.kullanici,
      required this.secim,
      required this.toplusec})
      : super(key: key);
  final KullaniciGiris kullanici;
  final int secim;
  final bool toplusec;
  final cont = Get.put(KitapController());

  final degisken = true.obs;
  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController().obs;

    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      endDrawer: KitapDrawer(
        kullanici: kullanici,
      ),
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        leading: Builder(
          builder: (context) => secim == 1 || secim == 2
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.line_weight),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
        ),
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
              final cont = Get.put(KitapController());
              cont.filtrearama = value;

              MetodModel z = MetodModel();
              z.kalinanSayfa = cont.simdikisayfa;
              z.kullaniciAdi = kullanici.kullaniciAdi.toString();
              z.parola = kullanici.parola.toString();
              z.lkSayfa = true;
              z.querry = value;
              z.filtrekitap = cont.kitapfiltre;
              Get.put(KitapController()).getSayfaFiltreKitap(z);
            }
          },
          controller: textEditingController.value,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
            hintText: " Kitapta Ara...",
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Color.fromARGB(255, 103, 103, 103),
              ),
            ),
            suffixIcon: Obx(
              () => IconButton(
                icon: Icon(degisken.value ? Icons.camera_alt : Icons.close),
                onPressed: degisken.value
                    ? () async {
                        String barcodeScanRes;

                        barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                                '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                        if (barcodeScanRes != "-1") {
                          textEditingController.value.text = barcodeScanRes;
                          degisken.value = false;
                        }
                      }
                    : () async {
                        textEditingController.value.text = "";
                        final cont = Get.put(KitapController());
                        MetodModel z = MetodModel();
                        z.kalinanSayfa = cont.simdikisayfa;
                        z.islem = "sayfa";
                        z.kullaniciAdi = kullanici.kullaniciAdi.toString();
                        z.parola = kullanici.parola.toString();
                        z.lkSayfa = true;
                        Get.put(KitapController()).getSayfaFiltreKitap(z);
                        degisken.value = true;
                        cont.filtresayfa = false;
                      },
              ),
            ),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14.0),
        ),
        iconTheme: const IconThemeData(color: Color.fromRGBO(174, 166, 166, 1)),
      ),
      body: BodyWidget(
        kullanici: kullanici,
        secim: secim,
      ),
    );
  }
}

@override
class BodyWidget extends StatelessWidget {
  BodyWidget({super.key, required this.kullanici, required this.secim});
  final cont = Get.put(KitapController());
  final contyazzar = Get.put(YazarController());
  final contkitapturu = Get.put(KitapTurController());
  final contyayinevi = Get.put(YayineviController());
  final int secim;
  final KullaniciGiris kullanici;
  final contR = ScrollController();

  @override
  Widget build(BuildContext context) {
    final kitcont = Get.put(KitapController());

    String optionprinttype = "58 mm";

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      MetodModel z = MetodModel();
      z.kalinanSayfa = kitcont.simdikisayfa;
      z.islem = "sayfa";
      z.kullaniciAdi = kullanici.kullaniciAdi.toString();
      z.parola = kullanici.parola.toString();
      z.lkSayfa = true;

      var dd = await Get.put(KitapController()).getSayfaFiltreKitap(z);
      //print(cont.totalPageCount);
      cont.sayfakitapList = dd;
      contR.addListener(() async {
        if (contR.position.atEdge) {
          if (contR.position.pixels != 0.0) {
            if (kitcont.totalPageCount! >= kitcont.simdikisayfa) {
              kitcont.isloading = true;
              MetodModel x = MetodModel();
              x.kalinanSayfa = kitcont.simdikisayfa;
              x.kullaniciAdi = kullanici.kullaniciAdi.toString();
              x.parola = kullanici.parola.toString();
              x.lkSayfa = false;
              x.filtrekitap = cont.kitapfiltre;

              MetodModel y = MetodModel();
              x.islem = "filtre";

              y.kalinanSayfa = kitcont.simdikisayfa;
              y.kullaniciAdi = kullanici.kullaniciAdi.toString();
              y.parola = kullanici.parola.toString();
              y.lkSayfa = false;
              y.querry = kitcont.filtrearama;
              y.filtrekitap = cont.kitapfiltre;

              kitcont.filtresayfa
                  ? await Get.put(KitapController()).getSayfaFiltreKitap(y)
                  : await Get.put(KitapController()).getSayfaFiltreKitap(x);

              if (kitcont.totalPageCount! > kitcont.simdikisayfa) {
                kitcont.isloading = true;
              } else {
                kitcont.isloading = false;
              }
            }
          }
        }
      });
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
            () => GestureDetector(
              child: ListView(
                shrinkWrap: true,
                controller: contR,
                children: [
                  ...cont.sayfakitapList!.asMap().entries.map(
                        (data) => FocusedMenuHolder(
                          onPressed: () async {
                            if (secim == 1) {
                              cont.secilenkitap = data.value.id;
                              if (cont.secilenkitap == data.value.id) {
                                var x = await Get.put(KitapController())
                                    .getTekKitap(
                                        kullanici.kullaniciAdi.toString(),
                                        kullanici.parola.toString(),
                                        data.value.id);

                                Get.back(result: x);
                              }
                            } else if (secim == 2) {
                              var x = await Get.put(KitapController())
                                  .getTekKitap(
                                      kullanici.kullaniciAdi.toString(),
                                      kullanici.parola.toString(),
                                      data.value.id);

                              Get.back(result: x);
                            }
                          },
                          menuItems: [
                            FocusedMenuItem(
                                backgroundColor:
                                    const Color.fromARGB(255, 110, 107, 107),
                                title: const Text("Düzenle"),
                                trailingIcon: const Icon(Icons.edit),
                                onPressed: () async {
                                  var tekkitap = await KitapController()
                                      .getTekKitap(
                                          kullanici.kullaniciAdi.toString(),
                                          kullanici.parola.toString(),
                                          data.value.id);

                                  await Get.put(YazarController()).getTekYazar(
                                      kullanici.kullaniciAdi.toString(),
                                      kullanici.parola.toString(),
                                      data.value.yazarId);
                                  await Get.put(YayineviController())
                                      .getTekYayinevi(
                                          kullanici.kullaniciAdi.toString(),
                                          kullanici.parola.toString(),
                                          data.value.yayinEviId);
                                  await Get.put(KitapTurController())
                                      .getTekKitapTur(
                                          kullanici.kullaniciAdi.toString(),
                                          kullanici.parola.toString(),
                                          data.value.kitapTurId);

                                  var result = await Get.to<Kitap>(
                                      () => KitapEkleDuzenleSayfasi(
                                            kullanici: kullanici,
                                            giristuru: "Düzenle",
                                            gelenkitap: tekkitap,
                                          ));
                                  if (result != null) {
                                    data.value.adi = result.adi;
                                    data.value.sayfaSayisi = result.sayfaSayisi;
                                    data.value.barkod = result.barkod;
                                    data.value.degisiklikTarihi =
                                        result.degisiklikTarihi;
                                    data.value.degisiklikYapan =
                                        result.degisiklikYapan;
                                    data.value.kayitTarihi = result.kayitTarihi;
                                    data.value.kayitYapan = result.kayitYapan;
                                    data.value.kitapTurId = result.kitapTurId;
                                    data.value.yayinEviId = result.yayinEviId;
                                    data.value.yazarId = result.yazarId;
                                    data.value.adiSoyadi = result.adisoyadi;
                                    data.value.resim = result.resim;
                                    cont.refResh;
                                    Get.defaultDialog(
                                        title: "Kitap Güncellendi",
                                        middleText: "",
                                        backgroundColor: const Color.fromARGB(
                                            255, 141, 141, 141));
                                  }
                                }),
                            FocusedMenuItem(
                              backgroundColor:
                                  const Color.fromARGB(255, 110, 77, 77),
                              title: const Text("Sil"),
                              trailingIcon: const Icon(Icons.delete),
                              onPressed: () async {
                                var silindimi = await KitapController()
                                    .silKitap(kullanici.kullaniciAdi!.obs,
                                        kullanici.parola!.obs, data.value.id);
                                //  bool sil = await silindimi;
                                if (silindimi) {
                                  cont.sayfakitapList?.removeAt(data.key);
                                } else {
                                  Get.defaultDialog(
                                      title: "Kitap Silinemedi",
                                      middleText: "Kitap Bir Öğrencide kayıtlı",
                                      backgroundColor: const Color.fromARGB(
                                          255, 110, 57, 57));
                                }
                              },
                            )
                          ],
                          child: Card(
                            child: ListTile(
                              subtitle: Text(
                                  'Yazarı :  ${data.value.adiSoyadi ?? ""}                                         '),
                              leading: const Icon(
                                Icons.menu_book_rounded,
                              ),
                              title: Text(data.value.adi ?? ""),
                            ),
                          ),
                        ),
                      ),
                  cont.isloading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox(
                          width: 0,
                          height: 0,
                        )
                ],
              ),
              onTap: () {},
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
                  Get.to(KitapEkleDuzenleSayfasi(
                    kullanici: kullanici,
                    giristuru: "Ekle",
                  ));
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(255, 138, 137, 137),
                  child: Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 80,
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
                  List<int> bytes = [];

                  final profile = await CapabilityProfile.load();
                  //burada generator sınıfı ile yazıcıya gönderilecek verileri oluşturuyoruz
                  final generator = Generator(
                      optionprinttype == "58 mm"
                          ? PaperSize.mm58
                          : PaperSize.mm80,
                      profile);
                  bytes += generator.reset();

                  final ImagePicker picker = ImagePicker();
                  final XFile? photo = await picker.pickImage(
                      imageQuality: 50,
                      maxHeight: 1000,
                      maxWidth: 1000,
                      source: ImageSource.gallery);
                  if (photo == null) null;
                  var data = await photo?.readAsBytes();

                  img.Image? image = img.decodeImage(data!);

                  bytes += generator.image(image!);

                  // // bytes listesinin içerisine yazdırmak istediğimiz verileri ekliyoruz

                  // //aşşağıdaki eklemeler generatora ait örneklerdir
                  // bytes += generator.text(
                  //     'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
                  // bytes += generator.text('Special 1: ñÑ àÀ èÈ éÉ üÜ çÇ ôÔ',
                  //     styles: const PosStyles(codeTable: 'CP1252'));
                  // bytes += generator.text('Special 2: blåbærgrød',
                  //     styles: const PosStyles(codeTable: 'CP1252'));

                  // bytes += generator.text('Bold text',
                  //     styles: const PosStyles(bold: true));
                  // bytes += generator.text('Reverse text',
                  //     styles: const PosStyles(reverse: true));
                  // bytes += generator.text('Underlined text',
                  //     styles: const PosStyles(underline: true), linesAfter: 1);
                  // bytes += generator.text('Align left',
                  //     styles: const PosStyles(align: PosAlign.left));
                  // bytes += generator.text('Align center',
                  //     styles: const PosStyles(align: PosAlign.center));
                  // bytes += generator.text('Align right',
                  //     styles: const PosStyles(align: PosAlign.right),
                  //     linesAfter: 1);

                  // bytes += generator.row([
                  //   PosColumn(
                  //     text: 'col3',
                  //     width: 3,
                  //     styles: const PosStyles(
                  //         align: PosAlign.center, underline: true),
                  //   ),
                  //   PosColumn(
                  //     text: 'col6',
                  //     width: 6,
                  //     styles: const PosStyles(
                  //         align: PosAlign.center, underline: true),
                  //   ),
                  //   PosColumn(
                  //     text: 'col3',
                  //     width: 3,
                  //     styles: const PosStyles(
                  //         align: PosAlign.center, underline: true),
                  //   ),
                  // ]);

                  // //Barkod

                  // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
                  // bytes += generator.barcode(Barcode.upcA(barData));

                  // //QR Kod
                  // bytes += generator.qrcode('example.com');

                  // bytes += generator.text(
                  //   'Text size 50%',
                  //   styles: const PosStyles(
                  //     fontType: PosFontType.fontB,
                  //   ),
                  // );
                  // bytes += generator.text(
                  //   'Text size 100%',
                  //   styles: const PosStyles(
                  //     fontType: PosFontType.fontA,
                  //   ),
                  // );
                  // bytes += generator.text(
                  //   'Text size 200%',
                  //   styles: const PosStyles(
                  //     height: PosTextSize.size2,
                  //     width: PosTextSize.size2,
                  //   ),
                  // );

                  // bytes += generator.feed(2);
                  // //bytes += generator.cut();

                  List<int> ticket = bytes;
                  final result = await PrintBluetoothThermal.writeBytes(ticket);
                  print("print test result:  $result");
                  return;
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(255, 138, 137, 137),
                  child: Icon(
                    Icons.print,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
