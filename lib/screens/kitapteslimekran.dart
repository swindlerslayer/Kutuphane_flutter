
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_teslim_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/Model/OgrenciKitap/ogrenci_kitap.dart';
import 'package:kutuphane_mobil_d/screens/kitapekran.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/screens/ogrenciekran.dart';

class KitapTeslimSayfasi extends StatelessWidget {
  KitapTeslimSayfasi({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;
  final ogrencicontroller = TextEditingController().obs;
  final kitapcontroller = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    String? teslimdate;
    RxString? alisdate = "".obs;
    final teslimtarih = TextEditingController(text: teslimdate).obs;

    final alistarih = TextEditingController(text: alisdate.value).obs;

    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text("Kitap Teslim Sayfası"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Obx(
          () {
            return Column(
              children: [
                TextField(
                  controller: alistarih.value,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Alış Tarihi",
                  ),
                  readOnly: true,
                  onTap: () async {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime.now(), onChanged: (date) {
                      alisdate.value = date.toString();
                    }, onConfirm: (date) {
                      alisdate.value = date.toString();

                      alistarih.value.text = DateFormat('dd-MM-yyy')
                          .format(date)
                          .toString()
                          .toString();
                    }, currentTime: DateTime.now(), locale: LocaleType.tr);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: teslimtarih.value,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Teslim Tarihi",
                  ),
                  readOnly: true,
                  onTap: () async {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime.now(),
                        onChanged: (date) {}, onConfirm: (date) {
                      // teslimdate = date.toString();
                      teslimtarih.value.text =
                          DateFormat('dd-MM-yyy').format(date).toString();
                    }, currentTime: DateTime.now(), locale: LocaleType.tr);
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 25),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: "Tarihleri Sıfırla",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 209, 209, 209)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            teslimtarih.value.text = "";
                            alistarih.value.text = "";
                          },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Obx(() => TextField(
                          controller: ogrencicontroller.value,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Öğrenci",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add_box),
                              onPressed: () async {
                                final cont = Get.put(KitapTeslimController());

                                var x = await Get.to(() => OgrenciSayfasi(
                                      kullanici: kullanici,
                                      secim: 1,
                                      toplusec: 
                                      false,
                                    ));
                                if (x != null) {
                                  ogrencicontroller.value.text = x.adiSoyadi;
                                  cont.secilenogrenciid = x.id;
                                }
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
                          controller: kitapcontroller.value,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Kitap",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add_box),
                              onPressed: () async {
                                final cont = Get.put(KitapTeslimController());

                                var x = await Get.to(() => KitapSayfasi(
                                      kullanici: kullanici,
                                      secim: 1,
                                      toplusec: false,
                                    ));
                                if (x != null) {
                                  kitapcontroller.value.text = x.adi;
                                  cont.secilenkitapid = x.id;
                                }
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
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (alistarih.value.text.isEmpty == true) {
                        Get.snackbar("Hata", "Alış Tarihi Boş Olamaz",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor:
                                const Color.fromARGB(255, 128, 104, 102));
                        return;
                      } else if (ogrencicontroller.value.text.isEmpty == true) {
                        Get.snackbar("Hata", "Öğrenci Boş Olamaz",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor:
                                const Color.fromARGB(255, 128, 104, 102));
                        return;
                      } else if (kitapcontroller.value.text.isEmpty == true) {
                        Get.snackbar("Hata", "Kitap Boş Olamaz",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor:
                                const Color.fromARGB(255, 128, 104, 102));
                        return;
                      } else{
                      final cont = Get.put(KitapTeslimController());

                      OgrenciKitap x = OgrenciKitap();
                      x.alisTarihi = alistarih.value.text;
                      x.kitapId = cont.secilenkitapid;
                      x.teslimTarihi = teslimtarih.value.text;
                      bool td;
                      if (teslimtarih.value.text.isEmpty) {
                        td = false;
                      } else {
                        td = true;
                      }
                      x.ogrenciId = cont.secilenogrenciid;
                      x.teslimDurumu = td;
                      //ekleguncelleKitapTeslim
                      var eklendi = await cont.ekleguncelleKitapTeslim(
                          kullanici.kullaniciAdi.toString(),
                          kullanici.parola.toString(),
                          x);
                      if (eklendi == "Eklendi") {
                        Get.snackbar("Başarılı", "Kitap Teslim Edildi",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor:
                                const Color.fromARGB(255, 107, 123, 107));
                      } else if (eklendi == "?") {
                        Get.snackbar("Hata", "Hata Oluştu",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor:
                                const Color.fromARGB(255, 128, 104, 102));
                      } else {
                        Get.snackbar("Hata", "Kitap Teslim Edilmedi",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor:
                                const Color.fromARGB(255, 128, 104, 102));
                      }
                    }},
                    child: const Text("Teslim Onayla!"))
              ],
            );
          },
        ),
      ),
    );
  }
}
