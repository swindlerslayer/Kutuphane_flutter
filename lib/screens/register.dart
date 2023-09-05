import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/register_controller.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/login.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final kadi = TextEditingController();
  final ksifre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 30,
                        )),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    RichText(
                      text: const TextSpan(
                          text: "Kayıt Ekranı",
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: kadi,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Kullanıcı Adı"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen Kullanıcı Adını Giriniz';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: ksifre,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Şifre"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen Şifrenizi Giriniz';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            backgroundColor: const Color.fromARGB(255, 132, 132,
                                132), // Text Color (Foreground color)
                          ),
                          onPressed: () async {
                            var cont = Get.put(RegisterController());

                            KullaniciGiris x = KullaniciGiris();
                            x.kullaniciAdi = kadi.text;
                            x.parola = ksifre.text;

                            var kayit = await cont.register(x);
                            if (kayit == "Eklendi") {
                              Get.defaultDialog(
                                  title: "Kayıt Başarılı",
                                  middleText: "",
                                  backgroundColor:
                                      const Color.fromARGB(255, 141, 141, 141));
                            }
                            Get.to(const Login());
                          },
                          child: const Text("Kayıt Ol"),
                        )))
                  ],
                ),
              ],
            )),
      ],
    ));
  }
}
