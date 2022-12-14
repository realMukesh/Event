import 'dart:developer';
import 'package:get/get.dart';

import '../common_controller/authentication_manager.dart';
import '../dashboard/view/dashboard_page.dart';
import '../login/view/loginPage.dart';

class SplashController extends GetxController {
  AuthenticationManager? controller;

  @override
  void onInit() {
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
      if (controller!.isLogin()) {
        Get.offAndToNamed(DashboardPage.routeName);
        //Get.offAndToNamed(LoginPage.routeName);
      } else {
       //Get.offAndToNamed(DashboardPage.routeName);
        Get.offAndToNamed(LoginPage.routeName);
      }
    });
  }
}
