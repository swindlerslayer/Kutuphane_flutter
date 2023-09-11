//Create a container that has text in middle

import 'package:flutter/material.dart';

class Deneme extends StatelessWidget {
  const Deneme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Deneme"),
      ),
      body: Center(
        child: Container(
          height: 250,
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 155, 155, 155),
          ),
          child: const Center(
            child: Text("Deneme"),
          ),
        ),
      ),
    );
  }
}
