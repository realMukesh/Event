import 'dart:developer';
import 'package:get/get.dart';
import '../common_controller/authentication_manager.dart';
import '../login/view/loginPage.dart';

class SplashController extends GetxController {
  AuthenticationManager? controller;

  @override
  void onInit() {
    controller = Get.find<AuthenticationManager>();
    log("splash has been mounted");
    nextScreen();
    super.onInit();
  }

  initialCall() async {
    controller = Get.find<AuthenticationManager>();
  }

  nextScreen() async {
    await initialCall();
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAndToNamed(LoginPage.routeName);
      /*if (controller!.isLogin()) {
         Get.offAndToNamed(DashboardPage.routeName);
      } else {
        Get.offAndToNamed(LoginPage.routeName);
      }*/
    });
  }
}
