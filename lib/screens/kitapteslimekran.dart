import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';

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
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextField(
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
                ),
                const SizedBox(
                  height: 50,
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
                              onPressed: () async {},
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
                              onPressed: () async {},
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
                    onPressed: () {}, child: const Text("Teslim Onayla!"))
              ],
            );
          },
        ),
      ),
    );
  }
}
