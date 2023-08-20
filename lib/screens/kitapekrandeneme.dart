// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kutuphane_mobil_d/Controllers/kitap_controller.dart';
// import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';

// class kitapekra2 extends StatefulWidget {
//   const kitapekra2({Key? key, required this.kullanici}) : super(key: key);
//   final KullaniciGiris kullanici;

//   @override
//   _kitapekra2State createState() => _kitapekra2State();
// }

// class _kitapekra2State extends State<kitapekra2> {
//   final cont = Get.put(KitapController());

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     var dd = await Get.put(KitapController()).getSayfaKitap(
//       widget.kullanici.kullaniciAdi.toString(),
//       widget.kullanici.parola.toString(),
//       cont.totalPageCount,
//     );

//     cont.sayfakitapList = dd;
//     print(cont.sayfakitapList?.length);
//   }


// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Obx(
//       () {
//         if (cont.sayfakitapList == null) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         // Veriyi liste olarak görüntüleme veya işleme yapma
//         return ListView.builder(
//           itemCount: cont.sayfakitapList!.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(cont.sayfakitapList![index].adi ?? 'Adı Yok'),
//               // Diğer verileri burada görüntüleyebilirsiniz
//             );
//           },
//         );
//       },
//     ),
//   );
// }

// }
