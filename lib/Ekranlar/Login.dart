import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Controllers/loginControls.dart';
import 'package:kutuphane_mobil_d/Ekranlar/AnaEkran.dart';
import 'package:kutuphane_mobil_d/Controllers/Degiskenler/Kullanici.dart';
import 'package:kutuphane_mobil_d/URL/url.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController kullaniciadicontroller = TextEditingController();
  TextEditingController sifrecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
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
                      border: OutlineInputBorder(), labelText: "Kullanıcı Adı"),
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
                    child: const Text('Giriş'),
                  ),
                ),
              ),
            ],
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
    TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    Kullanici? loggedInUser =
        await loginController.loginUser(context, kullaniciAdi, parola, false);
    if (loggedInUser?.kullaniciAdi != null) {
      // Giriş kontrol burada
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewScreen(kullanici: loggedInUser),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bilgileriniz Yanlış')),
      );
    }
  }
}
