import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/yayineviekran.dart';
import 'package:kutuphane_mobil_d/screens/yazarekran.dart';

class DenemeDizayn extends StatelessWidget {
  const DenemeDizayn({super.key, required this.kullanici});
  final KullaniciGiris kullanici;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Deneme Sayfası")),
      body: GestureDetector(
        onTap: () {},
        child: Stack(children: [
          Container(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 175,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Kitabın Yayınevi",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add_box),
                      onPressed: () {
                        Get.to(() => YazarSayfasi(
                              kullanici: kullanici,
                              secim: 1,
                              kitapID: 1042,
                            ));
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 164, 164, 164)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 175,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Kitabın Yayınevi",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add_box),
                      onPressed: () {
                        Get.to(() => YayineviSayfasi(kullanici: kullanici));
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 164, 164, 164)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
