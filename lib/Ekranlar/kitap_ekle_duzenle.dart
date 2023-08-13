import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Degiskenler/kitap.dart';

class KitapEkleDuzenleSayfasi extends StatelessWidget {
  final kullanici;
  final giristuru;
  final gelenkitap;
  const KitapEkleDuzenleSayfasi(
      {Key? key, this.kullanici, required this.giristuru, this.gelenkitap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kullaniciadicontroller = TextEditingController(text: gelenkitap.adi);
    final sifrecontroller =
        TextEditingController(text: gelenkitap.sayfaSayisi.toString());
    final barkodController =
        TextEditingController(text: gelenkitap.barkod.toString());

    print(gelenkitap.adi);

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: kullaniciadicontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "tekkitap"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Kitap Adini Giriniz';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: sifrecontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Sayfa Sayisi"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Sayfa Sayisini Giriniz';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: barkodController,
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    final k = Kitap();
                    k.adi = kullaniciadicontroller.text;
                    KitapController().ekleguncelleKitap(
                        kullanici.kullaniciAdi, kullanici.parola, k);
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
