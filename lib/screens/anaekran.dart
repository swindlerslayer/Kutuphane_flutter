// ignore: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/anasayfa_controller.dart';
import 'package:kutuphane_mobil_d/Model/kullanici.dart';

import 'nav_drawer.dart';

class NewScreen extends StatelessWidget {
  NewScreen({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;
  final cont = Get.put(AnasayfaController());

  @override
  Widget build(BuildContext context) {
    print(cont.kitapogrenci.length);
    const BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 131, 44, 208),
        Color.fromARGB(255, 71, 32, 88),
      ],
    ));

    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Ana Ekran'),
      ),
      body: Container(
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
            ListView.builder(
                shrinkWrap: true,
                itemCount: cont.kitapogrenci.length,
                itemBuilder: (context, index) {
                  var data = cont.kitapogrenci[index];

                  return Card(
                    child: ListTile(
                      title: Text(kullanici.toString()),
                      subtitle: Text(
                          'Orta yazi,          ${data.adiSoyadi /*  */}                               ${data.teslimDurumu} uzunlukta alt satira iniyor'),
                      isThreeLine: true,
                      leading: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Üst Yazi'),
                          Text('Alt Yazi'),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
