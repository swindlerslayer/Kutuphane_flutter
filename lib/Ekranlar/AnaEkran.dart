// ignore: file_names

import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav_drawer.dart';

import '../Degiskenler/kullanici.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    const BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 131, 44, 208),
        Color.fromARGB(255, 71, 32, 88),
      ],
    ));
    PopupMenuButton(
      icon: const Icon(Icons.settings),
      itemBuilder: (context) => [
        const PopupMenuItem(
          child: Text("Settings"),
        ),
        const PopupMenuItem(
          child: Text("Flutter.io"),
        ),
        const PopupMenuItem(
          child: Text("Google.com"),
        ),
      ],
    );
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text('Ana Ekran'),
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     Color.fromARGB(255, 131, 44, 208),
        //     Color.fromARGB(255, 71, 32, 88),
        //   ],
        // )),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            prototypeItem: ListTile(
              title: Text(kullanici.toString()),
            ),
            itemBuilder: (context, index) {
              return ListTile(
                //  title: Text('Three-line ListTile'),
                subtitle: Text(
                    'Orta yazi,          ${kullanici.kullaniciAdi /*  */}                               yeteri uzunlukta alt satira iniyor'),
                //trailing liste öğesinin sağına yerleştireceğimiz öğeler için...
                // trailing: Icon(Icons.more_vert),
                //trailing: IconButton(icon: Icon(Icons.more_vert), onPressed:(){}),
                trailing: GestureDetector(
                  child: const Icon(
                    Icons.more_vert,
                    color: Color.fromARGB(255, 231, 128, 37),
                  ),
                  onTap: () {
                    //logic to open POPUP window
                    print('Düğmeye basildi');
                  },
                ),
                isThreeLine: true,

                // leading: const Icon(Icons.person),
                leading: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Üst Yazi'),
                    Text('Alt Yazi'),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
