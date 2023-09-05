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
        appBar: AppBar(),
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
            child: Column(
              children: [
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
            )));
  }
}
