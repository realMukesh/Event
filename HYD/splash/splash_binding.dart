import 'package:get/get.dart';
import 'package:inventery/splash/splash_controller.dart';


class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());

  }
}