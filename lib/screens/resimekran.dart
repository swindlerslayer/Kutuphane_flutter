import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/resim_controller.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';

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

    //  Container(
    //           width: 50,
    //           height: 50,
    //           padding: const EdgeInsets.all(8),
    //           decoration: const BoxDecoration(
    //             borderRadius: BorderRadius.all(Radius.circular(10)),
    //             color: Color.fromARGB(255, 155, 155, 155),
    //           ),
    //           child: const Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Icon(
    //                 Icons.add,
    //                 color: Colors.white,
    //               ),
    //               Text("Resim Ekle")
    //             ],
    //           ),
    //         )
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
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: IconButton(
                  icon: const Icon(Icons.add_photo_alternate),
                  onPressed: () async {
                    List<File> selectedImages = [];
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickMultiImage(
                        imageQuality: 50, maxHeight: 1000, maxWidth: 1000);
                    List<XFile> xfilePick = pickedFile;

                    if (xfilePick.isNotEmpty) {
                      for (var i = 0; i < xfilePick.length; i++) {
                        selectedImages.add(File(xfilePick[i].path));
                      }
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Hiç Resim Seçilmedi!')));
                    }
                    //Resim Burada Ekleniyor
                  },
                ),
              )),
        ],
      ),
      body: gelenkitapid == 0
          ? const Icon(
              Icons.hourglass_empty,
              size: 123,
            )
          : Container(
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: cont.sayfaresimList!.length,
                itemBuilder: (context, index) {
                  var data = cont.sayfaresimList?[index];
                  return Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 155, 155, 155),
                      ),
                      child: Image.memory(base64Decode(data?.resim1)));
                },
              ),
            ),
    );
  }
}
