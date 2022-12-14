//import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/boldTextView.dart';
import 'package:inventery/customerWidget/loading.dart';
import 'package:inventery/dashboard/model/dashboard_model.dart';
import 'package:inventery/qr_code/zapping-qr_code_page.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common_controller/authentication_manager.dart';
import '../../enventory/view/user_list_page.dart';
import '../../login/view/online-registration.dart';
import '../../qr_code/qr_code_page.dart';
import '../../theme/app_colors.dart';
import '../../theme/ui_helper.dart';
import '../../zappingDashboard/view/zapping_page.dart';
import '../controller/dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  DashboardPage({Key? key}) : super(key: key);
  static const routeName = "/home_screen";

  final AuthenticationManager _authManager = Get.find();

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to exit an App'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GetBuilder<DashboardController>(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
            ),
            body: Container(
              padding: EdgeInsets.all(15),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Image.asset(
                        'assets/logo.png',
                        height: 50,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildLoadDashboard()
                    ],
                  ),
                  controller.isLoading.value
                      ? const Loading()
                      : const SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildLoadDashboard() {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: false,
        itemCount: controller.dashboardList.length,
        itemBuilder: (context, index) => _buildButton(index, context),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16),
      ),
    );
  }

  Widget buildChildMenuBody(int index, BuildContext context) {
    DashboardModel model = controller.dashboardList[index];
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
            color: model.isEnable ? tab_selected_color : grayColorLight,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                model.icon,
                height: 71,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                model.name,
                style: const TextStyle(
                    color: title_color, fontSize: 16, fontFamily: "Poppins"),
                textAlign: TextAlign.center,
              ),
              //RegularTextView(text: model.name,color: title_color,textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }

  _buildButton(int index, BuildContext context) {
    DashboardModel model = controller.dashboardList[index];
    return MaterialButton(
        animationDuration: const Duration(seconds: 1),
        color: model.isEnable ? tab_selected_color : grayColorLight,
        hoverColor: button_color,
        splashColor: button_color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          switch (index) {
            case 0:
              _scanQR(context);
              break;
            case 1:
              Get.toNamed(ZappingDashboardPage.routeName);
              break;
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                model.icon,
                height: 71,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                model.name,
                style: const TextStyle(
                    color: title_color, fontSize: 16, fontFamily: "Poppins"),
                textAlign: TextAlign.center,
              ),
              //RegularTextView(text: model.name,color: title_color,textAlign: TextAlign.center,)
            ],
          ),
        ));
  }

  Future _scanQR(BuildContext context) async {
    await Permission.storage.request();

    var scanResult = await Get.to(const QRViewPage());

    print(scanResult);

    if (scanResult != null && scanResult.isNotEmpty) {
      List<String> patternList = <String>[];
      patternList = scanResult.split(",");

      print(patternList[0].replaceAll('"', '\\"'));
      String code = patternList[0].replaceAll("[", "");
      String codepattern = code.replaceAll('"', "");
      print("code--------------$codepattern");

      if (scanResult.isNotEmpty) {
        var result = await controller.scanDetailResponse(context, codepattern);
        if (result['status']) {
          Get.toNamed(UserListPage.routeName);
        } else {
          UiHelper.showSnakbarMsg(context!, result['message']);
        }
      }
    }
  }
}
