import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/ogrenci_controller.dart';
import 'package:kutuphane_mobil_d/Model/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/ogrenciekran.dart';

import '../Degiskenler/Ogrenci.dart';

class OgrenciEkleDuzenleSayfasi extends StatelessWidget {
  const OgrenciEkleDuzenleSayfasi(
      {Key? key,
      required this.kullanici,
      required this.giristuru,
      this.gelenogrenci})
      : super(key: key);
  final KullaniciGiris kullanici;
  final String giristuru;
  final Ogrenci? gelenogrenci;
  @override
  Widget build(BuildContext context) {
    int? kitapid = gelenogrenci?.id ?? 0;

    final ogrencitextcontrol =
        TextEditingController(text: gelenogrenci?.adiSoyadi);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 252, 252)),
          onPressed: () async {
            var dd = await Get.put(OgrenciController()).getOgrenci(
                kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
            Get.put(OgrenciController()).ogrenciliste = dd ?? [];
            Get.back();
            Get.to(OgrenciSayfasi(kullanici: kullanici));
          },
        ),
        title: Text("Öğrenci $giristuru Sayfası"),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: ogrencitextcontrol,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Öğrenci adı"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Öğrenci Adını Giriniz';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    Ogrenci o = Ogrenci();
                    o.id = kitapid;
                    o.adiSoyadi = ogrencitextcontrol.text;

                    var kaydetGuncelleKontrol = await OgrenciController()
                        .ekleguncelleOgrenci(
                            kullanici.kullaniciAdi, kullanici.parola, o);

                    if (kaydetGuncelleKontrol == "Eklendi") {
                      Get.defaultDialog(
                          title: "Öğrenci Eklendi",
                          middleText: "",
                          backgroundColor:
                              const Color.fromARGB(255, 141, 141, 141));
                    } else if (kaydetGuncelleKontrol == "Güncellendi") {
                      Get.defaultDialog(
                          title: "Öğrenci Güncellendi",
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
