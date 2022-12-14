import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/loading.dart';
import 'package:inventery/dashboard/model/dashboard_model.dart';
import 'package:inventery/login/view/loginPage.dart';
import 'package:inventery/qr_code/zapping-qr_code_page.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common_controller/authentication_manager.dart';
import '../../qr_code/qr_code_page.dart';
import '../../theme/app_colors.dart';
import '../../theme/strings.dart';
import '../../theme/ui_helper.dart';
import '../controller/zapping_controller.dart';


class ZappingDashboardPage extends GetView<ZappingController> {
  ZappingDashboardPage({Key? key}) : super(key: key);
  static const routeName = "/zaping_home_screen";

  final AuthenticationManager _authManager = Get.find();


  @override
  Widget build(BuildContext context) {

    Future<bool> _onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => /*Navigator.of(context).pop(true)*/ Get.offNamedUntil(LoginPage.routeName, (route) => false),
              child: const Text('Yes'),
            ),
          ],
        ),
      )) ??
          false;
    }

    return WillPopScope(
        onWillPop: _onWillPop,
        child: GetBuilder<ZappingController>(
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
                padding: const EdgeInsets.all(15),
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
        ));
  }

  _buildLoadDashboard(){
    return Expanded(
      child: GridView.builder(
        shrinkWrap: false,
        itemCount: _authManager.locationList.length,
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
    String model=_authManager.locationList[index];

    return MaterialButton(
        animationDuration: const Duration(seconds: 1),
        color: tab_selected_color,
        hoverColor: button_color,
        splashColor: button_color,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () async {
          if(_authManager.getLocation()!=null){
            if(_authManager.getLocation()!.contains(model.substring(0, model.length - 1))){
              _scanQR(context);
            }else{
              UiHelper.showSnakbarMsg(context, "Please logout and login for re-location");
            }
          }else{
            var result=await UiHelper.showAlertDialog(title: MyStrings.crosspoles,yes:MyStrings.ok,no: "Cancel",message:"Are you sure you want to continue  with this location.");
            if(result){
              _authManager.setLocation(model.trim());
              _scanQR(context);
            }
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             // Image.asset(model.icon,height: 71,fit: BoxFit.contain,),
              const SizedBox(height: 6,),
              Text(model,style: const TextStyle(color: title_color,fontSize: 16,fontFamily: "Poppins"),textAlign: TextAlign.center,),
              //RegularTextView(text: model.name,color: title_color,textAlign: TextAlign.center,)
            ],
          ),
        ));
  }

  Future _scanQR(BuildContext context) async {
    await Permission.storage.request();
    Get.to(const ZappingQRPage());
  }

}
