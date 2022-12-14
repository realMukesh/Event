import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventery/splash/splash_controller.dart';

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
              color: Colors.white,
              padding: EdgeInsets.all(100),
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Image.asset('assets/logo.png'),
              ),
            ),
          );
        });
  }
}
