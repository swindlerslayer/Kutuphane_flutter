import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
        appBar: AppBar(
      //   title: const Text(data.toString()),
      title: const Text('Ana Ekran'),
    ));
  }
  // Widget build(BuildContext context) {
  //   final data = ModalRoute.of(context)?.settings.arguments;
  //   // Use the data to build the new screen

  //   return Container(

  //     // child: Text(data.toString()),
  //     child: const Text(
  //       'Ana Ekran',
  //       style: TextStyle(),
  //     ),
  //   );
}
