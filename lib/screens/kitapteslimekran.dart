import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';

class KitapTeslimSayfasi extends StatelessWidget {
  const KitapTeslimSayfasi({Key? key, required this.kullanici})
      : super(key: key);
  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    TextEditingController dateinput = TextEditingController();
    DateTime? dateTime;
    return Scaffold(
      drawer: NavDrawer(kullanici: kullanici),
      appBar: AppBar(
        title: const Text("Kitap Teslim Sayfası"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: 150,
        child: Column(children: [
          Container(
            child: TextField(
              controller: dateinput,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Teslim Tarihi",
              ),
              readOnly: true,
              onTap: () async {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2018, 3, 5),
                    maxTime: DateTime.now(),
                    onChanged: (date) {}, onConfirm: (date) {
                  date = dateTime!;
                  print('confirm $dateTime');
                }, currentTime: DateTime.now(), locale: LocaleType.tr);
              },
            ),
          ),
          Container(
            child: TextField(
              controller: dateinput,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Alış Tarihi",
              ),
              readOnly: true,
              onTap: () async {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2018, 3, 5),
                    maxTime: DateTime.now(),
                    onChanged: (date) {}, onConfirm: (date) {
                  date = dateTime!;
                  print('confirm $dateTime');
                }, currentTime: DateTime.now(), locale: LocaleType.tr);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
