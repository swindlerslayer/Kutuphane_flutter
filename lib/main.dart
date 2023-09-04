import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kutuphane_mobil_d/screens/loading.dart';

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
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 23,
            ),
            toolbarTextStyle: TextStyle(),
            iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            foregroundColor: Colors.black, //<-- SEE HERE
          ),
        ),
        home: const LoadingScreen());
  }
}
