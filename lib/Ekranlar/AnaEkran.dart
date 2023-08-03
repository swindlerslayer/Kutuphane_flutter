import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  var kullanici;

  NewScreen({super.key, required this.kullanici});

  @override
  Widget build(BuildContext context) {
    print(kullanici);
    return MaterialApp(
      title: 'Ana Ekran',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ana Ekran'),
        ),
        body: const Center(
          child: Text('n'),
        ),
      ),
    );
  }
}
