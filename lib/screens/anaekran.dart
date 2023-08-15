import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/anasayfa_controller.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Anasayfa'),
      ),
      body: BodyWidget(kullanici: kullanici),
    );
  }
}

class BodyWidget extends StatelessWidget {
  BodyWidget({super.key, required this.kullanici});
  final cont = Get.put(AnasayfaController());
  final KullaniciGiris kullanici;
  @override
  Widget build(BuildContext context) {
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
            () => ListView.builder(
                shrinkWrap: true,
                itemCount: cont.kitapogrenci.length,
                itemBuilder: (context, index) {
                  var data = cont.kitapogrenci[index];

                  return FocusedMenuHolder(
                    onPressed: () {},
                    menuItems: [
                      FocusedMenuItem(
                          backgroundColor:
                              const Color.fromARGB(255, 110, 107, 107),
                          title: const Text("Teslim Alındı"),
                          trailingIcon: const Icon(Icons.edit),
                          onPressed: () {}),
                      FocusedMenuItem(
                          backgroundColor:
                              const Color.fromARGB(255, 110, 57, 57),
                          title: const Text("Teslim Alınmadı"),
                          trailingIcon: const Icon(Icons.edit),
                          onPressed: () {})
                    ],
                    child: Card(
                      child: ListTile(
                        title: Text(data.adiSoyadi.toString()),
                        subtitle: Text(
                            'Orta yazi,                                     ${data.teslimDurumu} uzunlukta alt satira iniyor'),
                        isThreeLine: true,
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' ${data.alisTarihi}'),
                            Text('${data.teslimTarihi}'),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
