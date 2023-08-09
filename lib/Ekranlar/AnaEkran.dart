import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Ekranlar/nav-drawer.dart';

class NewScreen extends StatelessWidget {
  final kullanici;
  const NewScreen({Key? key, this.kullanici}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Kullanıcı Adı: ${kullanici?.kullaniciAdi}');
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
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        prototypeItem: ListTile(
          title: Text(kullanici.toString()),
        ),
        itemBuilder: (context, index) {
          return const ListTile(
            title: Text('Three-line ListTile'),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            //trailing liste öğesinin sağına yerleştireceğimiz öğeler için...
            trailing: Icon(Icons.more_vert),
            //trailing: IconButton(icon: Icon(Icons.more_vert), onPressed:(){}),

            isThreeLine: true,

            // leading: const Icon(Icons.person),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('leading Line 1'),
                Text('leading Line 2'),
              ],
            ),
            // title: Text(kullanici.kullaniciAdi.toString()),
            // textColor: const Color.fromARGB(255, 94, 94, 94)
          );
        },
      ),
    );
  }
}
