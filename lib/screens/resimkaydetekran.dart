import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kutuphane_mobil_d/Controllers/resim_controller.dart';

import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/Model/Resim/resimliste.dart';

class ResimKaydetmeSayfasi extends StatelessWidget {
  const ResimKaydetmeSayfasi(
      {super.key, required this.kullanici, required this.gelenkitapid});
  final KullaniciGiris kullanici;
  final int gelenkitapid;

  @override
  Widget build(BuildContext context) {
    final cont = Get.put(ResimController());

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   var dd = await cont.getResim(kullanici.kullaniciAdi.toString(),
    //       kullanici.parola.toString(), gelenkitapid);
    //   cont.sayfaresimList = dd;
    // });

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
            icon: const Icon(Icons.save),
            onPressed: () async {
              //bulk image save here
              var eklendi = await cont.topluResimEkle(
                  kullanici.kullaniciAdi.toString(),
                  kullanici.parola.toString(),
                  cont.ekleresimList);
              if (eklendi == "Eklendi") {
                Get.back(result: "kaydedildi");
              }
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
                  child: Obx(() => GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: cont.ekleresimList!.length,
                        itemBuilder: (context, index) {
                          var data = cont.ekleresimList?[index];
                          return GestureDetector(
                            onTap: () {},
                            child: FocusedMenuHolder(
                              openWithTap: true,
                              animateMenuItems: true,
                              menuWidth:
                                  MediaQuery.of(context).size.width * 0.50,
                              menuItems: [
                                FocusedMenuItem(
                                    backgroundColor:
                                        const Color.fromARGB(255, 110, 77, 77),
                                    title: const Text(
                                      "Sil",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    trailingIcon: const Icon(
                                      Icons.delete,
                                    ),
                                    onPressed: () async {
                                      // var silindi = await cont.getResimsil(
                                      //     kullanici.kullaniciAdi.toString(),
                                      //     kullanici.parola.toString(),
                                      //     data?.id ?? 0);

                                      // if (silindi == "silindi") {
                                      cont.ekleresimList?.removeAt(index);
                                      // } else {
                                      //   ScaffoldMessenger.of(context).showSnackBar(
                                      //       const SnackBar(
                                      //           content:
                                      //               Text('Resim Silinemedi!')));
                                      // }
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
                      )),
                ),
                Positioned(
                  right: 20,
                  bottom: 50,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                        ),
                        onPressed: () async {
                          List<File> selectedImages = [];
                          final picker = ImagePicker();
                          final pickedFile = await picker.pickMultiImage(
                              imageQuality: 70, maxHeight: 100, maxWidth: 100);
                          List<XFile> xfilePick = pickedFile;

                          if (xfilePick.isNotEmpty) {
                            for (var i = 0; i < xfilePick.length; i++) {
                              selectedImages.add(File(xfilePick[i].path));
                            }
                            for (var i = 0; i < selectedImages.length; i++) {
                              var tanim = base64.encode(
                                  await selectedImages[i].readAsBytes());
                              ListeResim z = ListeResim();
                              z.resim1 = tanim;
                              z.kitapId = gelenkitapid;
                              z.kayitYapan = kullanici.kullaniciAdi;

                              cont.ekleresimList?.add(z);

                              //convert file type to image
                        
                              //convert base64 to image
                              

                            }
                          } else {
                            Get.snackbar("Hata", "Hiç Resim Seçilmedi!");
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
