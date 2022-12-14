import 'dart:developer';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../common_controller/authentication_manager.dart';
import '../login/view/mainPage.dart';
import '../login/welcome_page.dart';

class SplashController extends GetxController {
  AuthenticationManager? controller;

  @override
  void onInit() {
    controller = Get.find<AuthenticationManager>();
    log("splash has been mounted");
    //nextScreen();
    super.onInit();
  }

  initialCall() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    controller = Get.find<AuthenticationManager>();
  }

  nextScreen() async {
    await initialCall();
    Future.delayed(const Duration(seconds: 0), () {
      Get.toNamed(WelcomePage.routeName);
      /*if (controller!.isLogin()) {
         Get.offAndToNamed(DashboardPage.routeName);
      } else {
        Get.offAndToNamed(LoginPage.routeName);
      }*/
    });
  }
}
