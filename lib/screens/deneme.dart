// import 'package:flutter/material.dart';
// import 'package:kutuphane_mobil_d/Model/Kullanici/kullanici.dart';
// import 'package:kutuphane_mobil_d/screens/nav_drawer.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key, required this.kullanici});
//   final KullaniciGiris kullanici;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: NavDrawer(kullanici: kullanici),
//       appBar: AppBar(),
//       endDrawer: const MyDrawer(),
//       body: const Center(
//         child: Center(child: Text('Text')),
//       ),
//     );
//   }
// }

// class MyDrawer extends StatefulWidget {
//   const MyDrawer({super.key});

//   @override
//   _DrawerState createState() => _DrawerState();
// }

// class _DrawerState extends State<MyDrawer> {
//   int? myIndex;
//   PageController? _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = PageController(initialPage: 0);
//   }

//   //The Logic where you change the pages
//   _onChangePage(int index) {
//     if (index != 0) myIndex = index;
//     _controller?.animateToPage(index.clamp(0, 1),
//         duration: const Duration(milliseconds: 500), curve: Curves.linear);
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: PageView.builder(
//       controller: _controller,
//       physics:
//           const NeverScrollableScrollPhysics(), //so the user can not move between pages
//       itemCount: 2,
//       itemBuilder: (context, index) {
//         // Original Drawer
//         if (index == 0) {
//           return MyWidget(
//             explore: () => _onChangePage(1),
//             settings: () => _onChangePage(2),
//           );
//         }
//         //Second Drawer form the PageView
//         switch (myIndex) {
//           case 1:
//             return MyExploreAll(goBack: () => _onChangePage(0));
//           case 2:
//           default:
//             return MySettings(goBack: () => _onChangePage(0));
//         }
//       },
//     ));
//   }
// }

// //The Menu Drawer (Your first image)
// class MyWidget extends StatelessWidget {
//   final VoidCallback? explore;
//   final VoidCallback? settings;

//   const MyWidget({super.key, this.explore, this.settings});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverList(
//             delegate: SliverChildListDelegate([
//           ListTile(
//             title: const Text('Send Money'),
//             onTap: () => print('Send Money'),
//           ),
//           ListTile(
//             title: const Text('Explore All Amazon Pay'),
//             onTap: () => print('Explore All Amazon Pay'),
//           ),
//           const Divider(
//             color: Colors.grey,
//             thickness: 1,
//           ),
//           ListTile(
//             title: const Text('Try Prime'),
//             onTap: () => print('Try Prime'),
//           ),
//           ListTile(
//             title: const Text('Explore All Programs'),
//             trailing: const Icon(Icons.arrow_forward_ios),
//             onTap: explore,
//           ),
//           const Divider(
//             color: Colors.grey,
//             thickness: 1,
//           ),
//           ListTile(
//             title: const Text('Fun Zone'),
//             onTap: () => print('Fun Zone'),
//           ),
//           const Divider(
//             color: Colors.grey,
//             thickness: 1,
//           ),
//           //More Stuff
//           ListTile(
//             title: const Text('Settings'),
//             trailing: const Icon(Icons.arrow_forward_ios),
//             onTap: settings,
//           ),
//         ]))
//       ],
//     );
//   }
// }

// // The settings Drawer(second image)
// class MySettings extends StatelessWidget {
//   final VoidCallback? goBack;

//   const MySettings({super.key, this.goBack});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverList(
//             delegate: SliverChildListDelegate([
//           ListTile(
//             leading: const Icon(Icons.arrow_back_ios),
//             title: const Text('Main Menu'),
//             onTap: goBack,
//           ),
//           ListTile(
//             title: const Text(
//               'Settings',
//               textScaleFactor: 3,
//             ),
//             onTap: () => print('Settings'),
//           ),
//           const Divider(
//             color: Colors.grey,
//             thickness: 1,
//           ),
//           ListTile(
//             title: const Text('Change Country'),
//             onTap: () => print('Change Country'),
//           ),
//           ListTile(
//             title: const Text('ETC'),
//             onTap: () => print('ETC'),
//           ),
//           const Divider(
//             color: Colors.grey,
//             thickness: 1,
//           ),
//           ListTile(
//             title: const Text('Dummy Text'),
//             onTap: () => print('Dummy Text'),
//           ),
//         ]))
//       ],
//     );
//   }
// }

// class MyExploreAll extends StatelessWidget {
//   final VoidCallback? goBack;

//   const MyExploreAll({super.key, this.goBack});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverList(
//             delegate: SliverChildListDelegate([
//           ListTile(
//             leading: const Icon(Icons.arrow_back_ios),
//             title: const Text('Main Menu'),
//             onTap: goBack,
//           ),
//           ListTile(
//             title: const Text(
//               'Explore All',
//               textScaleFactor: 3,
//             ),
//             onTap: () => print('Explore'),
//           ),
//           const Divider(
//             color: Colors.grey,
//             thickness: 1,
//           ),
//         ]))
//       ],
//     );
//   }
// }

// class MyInnerDrawer extends StatelessWidget {
//   final String name;
//   final PageController _controller;

//   const MyInnerDrawer(this._controller, this.name, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       ListTile(
//         title: Text(name),
//         trailing: const Icon(Icons.arrow_back_ios),
//         onTap: () => _controller.animateToPage(0,
//             duration: const Duration(milliseconds: 500), curve: Curves.linear),
//       )
//     ]);
//   }
// }
