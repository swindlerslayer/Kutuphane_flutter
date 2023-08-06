import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kutuphane_mobil_d/Ekranlar/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Login Dars',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const Login(
          title: ('Giriş'),
          key: null,
        ));
  }
}
