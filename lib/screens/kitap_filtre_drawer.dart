import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';

class KitapDrawer extends StatelessWidget {
  const KitapDrawer({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Anasayfa'),
            onTap: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
    );
  }
}
