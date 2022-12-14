import 'package:get/get.dart';
import 'package:inventery/enventory/controller/onlineRedemtionController.dart';
import 'package:inventery/zappingDashboard/controller/zapping_controller.dart';
import 'dashboard_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());
    Get.put<ZappingController>(ZappingController());

  }
}