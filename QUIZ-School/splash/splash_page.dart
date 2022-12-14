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
            body: Container(
              padding: const EdgeInsets.all(0),
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/splash.png'),fit: BoxFit.cover)
              ),
              child: const Center(
                  child:BoldTextView(text: "Aditya Birla Quiz Competition",color: Colors.white,textSize: 30,)
              ),
            ),
          );
        });
  }
}
