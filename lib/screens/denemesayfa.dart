// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class DenemeSayfasi extends StatelessWidget {
//   DenemeSayfasi({super.key});
//   final degisken = true.obs;

//   @override
//   Widget build(BuildContext) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: () async {
//               //Toplu resim silme
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [
//               Color.fromARGB(255, 121, 121, 121),
//               Color.fromARGB(255, 44, 44, 44),
//             ],
//           ),
//         ),
//         child: ListView(children: [
//           Card(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const ListTile(
//                   subtitle: Text('Yazarı :   Ali Candan      '),
//                   leading: Icon(
//                     Icons.menu_book_rounded,
//                   ),
//                   title: Text("Derin"),
//                 ),
//                 Checkbox(
//                   onChanged: (value) {},
//                   checkColor: Colors.white,
//                   activeColor: Colors.blue,
//                   value: true,
//                 )
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
