import 'package:get/get.dart';
import 'package:inventery/dashboard/controller/dashboard_controller.dart';
import 'zapping_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ZappingController>(ZappingController());
    Get.put<DashboardController>(DashboardController());

  }
}