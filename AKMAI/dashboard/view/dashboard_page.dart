//import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/loading.dart';
import 'package:inventery/dashboard/model/dashboard_model.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common_controller/authentication_manager.dart';
import '../../qr_code/qr_code_page.dart';
import '../../theme/app_colors.dart';
import '../controller/dashboard_controller.dart';


class DashboardPage extends GetView<DashboardController> {
  DashboardPage({Key? key}) : super(key: key);
  static const routeName = "/home_screen";

  final AuthenticationManager _authManager = Get.find();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
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
                    const SizedBox(height: 15,),
                    Image.asset('assets/logo.png',height: 50,),
                    const SizedBox(height: 30,),
                    _buildLoadDashboard()
                  ],
                ),
                controller.isLoading.value?const Loading():const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  _buildLoadDashboard(){
    return Expanded(
      child: GridView.builder(
        shrinkWrap: false,
        itemCount: controller.dashboardList.length,
        itemBuilder: (context, index) =>
            _buildButton(index, context),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16),
      ),
    );

  }

  _buildButton(int index, BuildContext context){
    DashboardModel model=controller.dashboardList[index];
    return MaterialButton(
        animationDuration: const Duration(seconds: 1),
        color: model.isEnable?tab_selected_color:grayColorLight,
        hoverColor: button_color,
        splashColor: button_color,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          switch(index){
            case 0:
              _scanQR(context);
              break;
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(model.icon,height: 71,fit: BoxFit.contain,),
              const SizedBox(height: 6,),
              Text(model.name,style: const TextStyle(color: title_color,fontSize: 16,fontFamily: "Poppins"),textAlign: TextAlign.center,),
              //RegularTextView(text: model.name,color: title_color,textAlign: TextAlign.center,)
            ],
          ),
        ));
  }

  Future _scanQR(BuildContext context) async {
    await Permission.storage.request();
    Get.to(const QRViewPage());
    /*var scanResult = await Get.to(const QRViewPage());
    if (scanResult != null && scanResult.isNotEmpty) {
      if (scanResult.isNotEmpty) {
        var result = await controller.scanDetailResponse(
            context, scanResult);
        if (result['status']) {
          Get.toNamed(UserListPage.routeName);
        }
      }
    }*/
  }

}
