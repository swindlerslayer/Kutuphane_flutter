import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/yazar_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';

import '../Model/Yazar/yazar.dart';

class YazarEkleDuzenleSayfasi extends StatelessWidget {
  const YazarEkleDuzenleSayfasi(
      {Key? key,
      required this.kullanici,
      required this.giristuru,
      this.gelenyazar})
      : super(key: key);
  final KullaniciGiris kullanici;
  final String giristuru;
  final Yazar? gelenyazar;
  @override
  Widget build(BuildContext context) {
    int? kitapid = gelenyazar?.id ?? 0;

    final yazartextcontrol = TextEditingController(text: gelenyazar?.adiSoyadi);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 252, 252)),
          onPressed: () async {
            Get.back();
          },
        ),
        title: Text("Yazar $giristuru Sayfası"),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: yazartextcontrol,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Yazar adı"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Yazar Adını Giriniz';
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
                    Yazar y = Yazar();
                    y.id = kitapid;
                    y.adiSoyadi = yazartextcontrol.text;

                    var kaydetGuncelleKontrol = await YazarController()
                        .ekleguncelleYazar(kullanici.kullaniciAdi.toString(),
                            kullanici.parola.toString(), y);

                    if (kaydetGuncelleKontrol == "Eklendi") {
                      Get.defaultDialog(
                          title: "Yazar Eklendi",
                          middleText: "",
                          backgroundColor:
                              const Color.fromARGB(255, 141, 141, 141));
                    } else if (kaydetGuncelleKontrol == "Güncellendi") {
                      var tekyazar = await YazarController().getTekYazar(
                          kullanici.kullaniciAdi.toString(),
                          kullanici.parola.toString(),
                          y.id);
                      Get.back<Yazar>(result: tekyazar);
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
