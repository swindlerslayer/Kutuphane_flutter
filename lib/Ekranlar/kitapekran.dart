import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class KitapSayfasi extends StatelessWidget {
  KitapSayfasi({Key? key, this.kullanici}) : super(key: key);
  final cont = Get.put(kitapcontroller());
  final kullanici;
  // var kitaplar = kitapcontroller.GetKitap(
  //     kullanici.kullaniciAdi.toString(), kullanici.parola.toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Kitap Sayfası'),
      ),
      body: Column(
        children: <Widget>[
          Obx(
            () => ListView.builder(
              
              shrinkWrap: true,
              itemCount: cont.kitapList.length,
              itemBuilder: (context, index) {
                var data = cont.kitapList[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.menu_book_rounded,
                    ),
                    title: Text(data.adi ?? ""),
                  ),
                  
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
