import 'package:flutter/material.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';

class KitapDrawer extends StatelessWidget {
  KitapDrawer({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;
  final sayfasayimintextcontroller = TextEditingController();
  final sayfasayimaxtextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ExpansionTile(
            title: const Text("Yazar"),
            children: [
              ListTile(
                trailing: const Icon(Icons.add),
                title: RichText(
                  text: const TextSpan(
                    text: "Yazar Ekle",
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(
                child: ListTile(
                  trailing: const Icon(Icons.abc),
                  title: const Text("2"),
                  onTap: () {},
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("Yayınevi"),
            children: [
              ListTile(
                trailing: const Icon(Icons.abc),
                title: const Text("1"),
                onTap: () {},
              ),
              SizedBox(
                child: ListTile(
                  trailing: const Icon(Icons.abc),
                  title: const Text("2"),
                  onTap: () {},
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("Kitap Türü"),
            children: [
              ListTile(
                trailing: const Icon(Icons.abc),
                title: const Text("1"),
                onTap: () {},
              ),
              SizedBox(
                child: ListTile(
                  trailing: const Icon(Icons.abc),
                  title: const Text("2"),
                  onTap: () {},
                ),
              )
            ],
          ),
          ExpansionTile(
            title: const Text("Sayfa Sayısı"),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: sayfasayimintextcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Minimum Sayfa Sayısı"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: sayfasayimaxtextcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Maksimum Sayfa Sayısı"),
                ),
              ),
            ],
          ),
          ListTile(
            trailing: const Icon(
              Icons.check_circle,
            ),
            //  leading: const Icon(Icons.abc),
            title: Align(
              alignment: const Alignment(0.2, 0),
              child: RichText(
                text: const TextSpan(
                    text: "Filtreyi uygula",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
