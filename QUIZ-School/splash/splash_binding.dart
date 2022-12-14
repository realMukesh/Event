import 'package:get/get.dart';
import 'package:firebase_chat/splash/splash_controller.dart';


class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());

  }
}