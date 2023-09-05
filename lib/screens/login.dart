import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/logincontrols.dart';
import 'package:kutuphane_mobil_d/screens/anaekran.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({Key? key, this.kullaniciadi, this.parola, this.ischecked})
      : super(key: key);
  final String? kullaniciadi;
  final String? parola;
  final bool? ischecked;
  @override
  Widget build(BuildContext context) {
    var cont0 = Get.put(_LoginController());
    var cont = Get.put(LoginController());
    TextEditingController kullaniciadicontroller =
        TextEditingController(text: kullaniciadi);
    TextEditingController sifrecontroller = TextEditingController(text: parola);
    ischecked == false ? cont.checkedstatus = false : cont.checkedstatus = true;

    return Scaffold(
      body: ListView(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: kullaniciadicontroller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Kullanıcı Adı"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: sifrecontroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Şifre"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16.0),
                      child: Obx(
                        () => Checkbox(
                          value: cont.checkedstatus,
                          onChanged: (value) async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            cont.checkedstatus = value!;
                            if (cont.checkedstatus == true) {
                              await prefs.setBool(
                                  'ischecked', cont.checkedstatus!);
                            } else {
                              await prefs.setBool(
                                  'ischecked', cont.checkedstatus!);
                            }
                          },
                        ),
                      ),
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
                        onPressed: () {
                          String kullaniciAdi = kullaniciadicontroller.text;
                          String parola = sifrecontroller.text;
                          cont.loginUser(kullaniciAdi, parola);
                          cont0._loginUser(kullaniciAdi, parola);
                        },
                        child: const Text('Giriş Yap'),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          backgroundColor: const Color.fromARGB(255, 132, 132,
                              132), // Text Color (Foreground color)
                        ),
                        onPressed: () {
                          Get.to(const Register());
                        },
                        child: const Text("Hesabın Yoksa Kayıt Ol"),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginController {
  final String routeName = '/new_screen';

  void _loginUser(
    String kullaniciAdi,
    String parola,
  ) async {
    LoginController loginController = LoginController();

    KullaniciGiris? loggedInUser =
        await loginController.loginUser(kullaniciAdi, parola);

    if (loggedInUser?.kullaniciAdi != null) {
      Get.to(NewScreen(kullanici: loggedInUser!));
    } else {
      Get.defaultDialog(
          title: "Giriş Başarısız",
          middleText: "Girdiğiniz bilgiler Yanlış",
          backgroundColor: const Color.fromARGB(255, 110, 57, 57));
    }
  }
}
