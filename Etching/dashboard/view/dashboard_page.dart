import 'package:firebase_chat/customerWidget/regularTextView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_controller/authentication_manager.dart';
import '../../theme/app_colors.dart';
import '../controller/dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  DashboardPage({Key? key}) : super(key: key);
  static const routeName = "/home_screen";
  final AuthenticationManager _authManager = Get.find();

  List<String> bottomTitle = [
    "Master",
    "User",
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/splash.png",),fit: BoxFit.cover)
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(
                  color: questionColor,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: RegularTextView(text: _authManager.getRole()=="1"?_authManager.getSchoolName()??"":_authManager.getTeamName()??"",color: Colors.black,textSize: 12,),),
            ),
            body:  SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Text("fgg"),
            ),
          ),
        );
      },
    );
  }
}
