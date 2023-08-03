import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
            // child içerisinde birden fazlar children öğesi alabiliyor aşşağıda
            //olduğu gibi içerisine birden fazla text veya button veya başka componentlerden birini ekleyebilirsin
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
                      return 'Lutfen Kullanıcı Adınızı Giriniz';
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
                        // Navigate the user to the Home page
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Lütfen Bilgilerinizi Giriniz')),
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
}
