import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil_d/Model/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/yayineviekran.dart';

import '../Model/yayinevi.dart';

class YayineviEkleDuzenleSayfasi extends StatelessWidget {
  const YayineviEkleDuzenleSayfasi(
      {Key? key,
      required this.kullanici,
      required this.giristuru,
      this.gelenyayinevi})
      : super(key: key);
  final KullaniciGiris kullanici;
  final String giristuru;
  final Yayinevi? gelenyayinevi;
  @override
  Widget build(BuildContext context) {
    int? kitapid = gelenyayinevi?.id ?? 0;

    final yayinevitextcontrol = TextEditingController(text: gelenyayinevi?.adi);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 252, 252)),
          onPressed: () async {
            var dd = await Get.put(YayineviController()).getYayinevi(
                kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
            Get.put(YayineviController()).yayineviliste = dd ?? [];
            Get.back();
            Get.to(YayineviSayfasi(kullanici: kullanici));
          },
        ),
        title: Text("Yayınevi $giristuru Sayfası"),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: yayinevitextcontrol,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Yayınevi adı"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Yayınevi Adını Giriniz';
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
                    Yayinevi y = Yayinevi();
                    y.id = kitapid;
                    y.adi = yayinevitextcontrol.text;

                    var kaydetGuncelleKontrol = await YayineviController()
                        .ekleguncelleYayinevi(
                            kullanici.kullaniciAdi, kullanici.parola, y);

                    if (kaydetGuncelleKontrol == "Eklendi") {
                      Get.defaultDialog(
                          title: "Yayınevi Eklendi",
                          middleText: "",
                          backgroundColor:
                              const Color.fromARGB(255, 141, 141, 141));
                    } else if (kaydetGuncelleKontrol == "Güncellendi") {
                      Get.defaultDialog(
                          title: "Yayınevi Güncellendi",
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
