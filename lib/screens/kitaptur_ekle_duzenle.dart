import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitapturu_controller.dart';
import 'package:kutuphane_mobil_d/Model/KitapTur/kitapturu.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';


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
            Get.back();
          },
        ),
        title: Text("Kitap Türü $giristuru Sayfası"),
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
                    border: OutlineInputBorder(), labelText: "Kitap Tür adı"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Tür Adını Giriniz';
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
                        .ekleguncelleKitapTur(kullanici.kullaniciAdi!.obs,
                            kullanici.parola!.obs, y);

                    if (kaydetGuncelleKontrol == "Eklendi") {
                      Get.back(result: "eklendi");
                    } else if (kaydetGuncelleKontrol == "Güncellendi") {
                      var tekkitap = await KitapTurController().getTekKitapTur(
                          kullanici.kullaniciAdi.toString(),
                          kullanici.parola.toString(),
                          y.id);
                      Get.back<KitapTur>(result: tekkitap);
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
//