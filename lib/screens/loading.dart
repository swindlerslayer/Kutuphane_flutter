import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil_d/Controllers/logincontrols.dart';
import 'package:kutuphane_mobil_d/screens/login.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  static const routeName = '/loading';

  @override
  Widget build(BuildContext context) {
    var cont = Get.put(LoginController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var checked = await cont.isCheckedBefore();
      if (checked == true) {
        var dd = await cont.getUserCredentials();
        var ddd = dd.toString().split(" ");
        //  cont0._loginUser(ddd[0], ddd[1]);
        //wait 2 seconds before next page
        Future.delayed(const Duration(seconds: 3), () {
          Get.to(() => Login(
                kullaniciadi: ddd[0],
                parola: ddd[2],
                ischecked: true,
              ));
        });
      } else {
        Get.to(() => const Login(
              ischecked: false,
            ));
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
