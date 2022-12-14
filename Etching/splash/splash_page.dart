import 'package:firebase_chat/customerWidget/boldTextView.dart';
import 'package:firebase_chat/theme/app_colors.dart';
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
            appBar: AppBar(toolbarHeight: 0),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/outer_bg.png'),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/inner_bg.png'),
                              fit: BoxFit.cover))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/logo.png",
                          height: 50,
                        )),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () {
                            controller.nextScreen();
                          },
                          child: Image.asset(
                            "assets/start_btn.png",
                            height: 60,
                          ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "DISCOVERY IS YOURS TO TAKE",
                          style: TextStyle(
                              fontFamily: "Brewmaster",
                              fontSize: 20,color: appBarColor,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
