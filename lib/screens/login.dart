import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/anasayfa_controller.dart';
import 'package:kutuphane_mobil_d/Controllers/logincontrols.dart';
import 'package:kutuphane_mobil_d/screens/anaekran.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController kullaniciadicontroller =
      TextEditingController(text: "deneme");
  TextEditingController sifrecontroller = TextEditingController(text: "deneme");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: kullaniciadicontroller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Kullanıcı Adı"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen Kullanıcı Adınızı Giriniz';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: sifrecontroller,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: const Color.fromARGB(255, 132, 132,
                            132), // Text Color (Foreground color)
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String kullaniciAdi = kullaniciadicontroller.text;
                          String parola = sifrecontroller.text;
                          _loginUser(context, kullaniciAdi, parola);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Lütfen Bilgilerinizi Giriniz'),
                            ),
                          );
                        }
                      },
                      child: const Text('Giriş Yap'),
                    ),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
      ),
    );
  }

  final String routeName = '/new_screen';

  void _loginUser(
    BuildContext context,
    String kullaniciAdi,
    String parola,
  ) async {
    LoginController loginController = LoginController();

    KullaniciGiris? loggedInUser =
        await loginController.loginUser(context, kullaniciAdi, parola);

    if (loggedInUser?.kullaniciAdi != null) {
      var dd = await Get.put(AnasayfaController())
          .getOgrenciKitap(kullaniciAdi.toString(), parola.toString());
      Get.put(AnasayfaController()).kitapogrenci = dd ?? [];
      Get.back();

      Get.to(NewScreen(kullanici: loggedInUser!));
    } else {
      Get.defaultDialog(
          title: "Giriş Başarısız",
          middleText: "Girdiğiniz bilgiler Yanlış",
          backgroundColor: const Color.fromARGB(255, 110, 57, 57));
    }
  }
}
