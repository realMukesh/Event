import 'package:get/get.dart';
import 'dashboard_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());

  }
}