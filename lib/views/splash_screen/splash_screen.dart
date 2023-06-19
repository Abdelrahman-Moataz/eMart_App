import 'package:emart/consts/colors.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/views/auth_screen/login_screen.dart';
import 'package:emart/widgets_common/applogo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // creating a method to change screen

  changeScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        // using getX
        //Get.to(() => const LoginScreen());

        /// if user is logged in or not
        auth.authStateChanges().listen((User? user) {
          if (user == null && mounted) {
            Get.to(() => const LoginScreen());
          } else {
            Get.to(() => const Home());
          }
        });
      },
    );
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appName.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appVersion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
