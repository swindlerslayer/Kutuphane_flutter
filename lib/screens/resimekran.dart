import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/resim_controller.dart';

import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/resimkaydetekran.dart';

class ResimSayfasi extends StatelessWidget {
  const ResimSayfasi(
      {super.key, required this.kullanici, required this.gelenkitapid});
  final KullaniciGiris kullanici;
  final int gelenkitapid;

  @override
  Widget build(BuildContext context) {
    final cont = Get.put(ResimController());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var dd = await cont.getResim(kullanici.kullaniciAdi.toString(),
          kullanici.parola.toString(), gelenkitapid);
      cont.sayfaresimList = dd;
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {},
          child: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 255, 252, 252)),
            onPressed: () async {
              Get.back();
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              //Toplu resim silme
            },
          ),
        ],
      ),
      body: gelenkitapid == 0
          ? const Icon(
              Icons.hourglass_empty,
              size: 123,
            )
          : Stack(
              fit: StackFit.expand,
              children: [
                Container(
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
                  child: Obx(
                    () => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: cont.sayfaresimList!.length,
                      itemBuilder: (context, index) {
                        var data = cont.sayfaresimList?[index];
                        return GestureDetector(
                          onTap: () {},
                          child: FocusedMenuHolder(
                            menuItems: [
                              FocusedMenuItem(
                                  backgroundColor:
                                      const Color.fromARGB(255, 110, 77, 77),
                                  title: const Text(
                                    "Sil",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                  trailingIcon: const Icon(
                                    Icons.delete,
                                  ),
                                  onPressed: () async {
                                    var silindi = await cont.getResimsil(
                                        kullanici.kullaniciAdi.toString(),
                                        kullanici.parola.toString(),
                                        data?.id ?? 0);

                                    if (silindi == "silindi") {
                                      cont.sayfaresimList?.removeAt(index);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Resim Silinemedi!')));
                                    }
                                  }),
                            ],
                            onPressed: () {},
                            child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromARGB(255, 155, 155, 155),
                                ),
                                child:
                                    Image.memory(base64Decode(data?.resim1))),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () async {
                        var result = await Get.to<String>(ResimKaydetmeSayfasi(
                          kullanici: kullanici,
                          gelenkitapid: gelenkitapid,
                        ));
                        if (result == "kaydedildi") {
                          var dd = await cont.getResim(
                              kullanici.kullaniciAdi.toString(),
                              kullanici.parola.toString(),
                              gelenkitapid);
                          cont.sayfaresimList = dd;
                          Get.defaultDialog(
                              title: "Resimler Kaydedildi",
                              middleText: " İşlem Başarılı ",
                              backgroundColor:
                                  const Color.fromARGB(255, 141, 141, 141));
                        }
                      },
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromARGB(255, 138, 137, 137),
                        child: Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
