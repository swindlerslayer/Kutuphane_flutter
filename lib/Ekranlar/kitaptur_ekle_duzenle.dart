import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitapturu_controller.dart';
import 'package:kutuphane_mobil_d/Degiskenler/kitapturu.dart';
import 'package:kutuphane_mobil_d/Degiskenler/kullanici.dart';
import 'package:kutuphane_mobil_d/Ekranlar/kitapturuekran.dart';

class KitapTurEkleDuzenleSayfasi extends StatelessWidget {
  const KitapTurEkleDuzenleSayfasi(
      {Key? key,
      required this.kullanici,
      required this.giristuru,
      this.gelenkitaptur})
      : super(key: key);
  final KullaniciGiris kullanici;
  final String giristuru;
  final KitapTur? gelenkitaptur;
  @override
  Widget build(BuildContext context) {
    int? kitapid = gelenkitaptur?.id ?? 0;

    final kitapturtextcontrol = TextEditingController(text: gelenkitaptur?.adi);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 252, 252)),
          onPressed: () async {
            var dd = await Get.put(KitapTurController()).getKitapTur(
                kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
            Get.put(KitapTurController()).kitapturList = dd ?? [];
            Get.back();
            Get.to(KitapTurSayfasi(kullanici: kullanici));
          },
        ),
        title: Text("Kitap Tür $giristuru Sayfası"),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: kitapturtextcontrol,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Kitap Türü adı"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Kitap Türünü Giriniz';
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
                    KitapTur y = KitapTur();
                    y.id = kitapid;
                    y.adi = kitapturtextcontrol.text;

                    var kaydetGuncelleKontrol = await KitapTurController()
                        .ekleguncelleKitapTur(
                            kullanici.kullaniciAdi, kullanici.parola, y);

                    if (kaydetGuncelleKontrol == "Eklendi") {
                      Get.defaultDialog(
                          title: "Kitap Türü Eklendi",
                          middleText: "",
                          backgroundColor:
                              const Color.fromARGB(255, 141, 141, 141));
                    } else if (kaydetGuncelleKontrol == "Güncellendi") {
                      Get.defaultDialog(
                          title: "Kitap Türü Güncellendi",
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
