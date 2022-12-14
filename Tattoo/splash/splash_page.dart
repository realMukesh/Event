import 'package:firebase_chat/customerWidget/boldTextView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_chat/splash/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              padding: const EdgeInsets.all(0),
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/splash.png'),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/logo.png",
                          height: 50,
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                            onTap: () {
                              controller.nextScreen();
                            },
                            child: Image.asset(
                              "assets/start_btn.png",
                              height: 60,
                            ))),
                  )
                ],
              ),
            ),
          );
        });
  }


}
