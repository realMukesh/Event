import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/boldTextView.dart';
import 'package:inventery/customerWidget/regularTextView.dart';
import 'package:inventery/routes/my_constant.dart';

import '../../common_controller/authentication_manager.dart';
import '../../customerWidget/toolbarTitle.dart';
import '../../login/controller/loginController.dart';
import '../../theme/app_colors.dart';
class ProfilePage extends StatelessWidget {
   ProfilePage({Key? key}) : super(key: key);
   final AuthenticationManager controller=Get.find();
   final loginController=Get.put(LoginController());



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: black),
        title: const ToolbarTitle(title: 'Profile'),
        shape:  const Border(
            bottom: BorderSide(
                color: grayColorLight,
                width: 1
            )
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox(height: 100,width: 100,child: CircleAvatar(backgroundImage: NetworkImage(
                controller.getProfileImage()??""
            ),),),
            const Divider(height: 12,),
            ListTile(
              title: const BoldTextView(text: "Full Name",textAlign: TextAlign.start,),
              subtitle: RegularTextView(text: controller.getUsername()??"",),
            ),
            const Divider(height: 12,),
            ListTile(
              title: const BoldTextView(text: "Mobile",textAlign: TextAlign.start,),
              subtitle: RegularTextView(text: controller.getEmail()??"",),
            ),
            const Divider(height: 12,),
            ListTile(
              title: const BoldTextView(text: "Email",textAlign: TextAlign.start,),
              subtitle: RegularTextView(text: controller.getMobile()??"",),
            ),
            const Divider(height: 12,),
            ListTile(
              title: const BoldTextView(text: "Social Id",textAlign: TextAlign.start,),
              subtitle: RegularTextView(text: controller.getEmail()??"",),
            ),
            const Divider(height: 30,),
            FloatingActionButton.extended(
              heroTag: "Logout",
              backgroundColor: black,
              onPressed: (){
                loginController.logoutUser(context);
              }, label: const RegularTextView(text: 'Sign out',color: Colors.white,),icon: Icon(Icons.logout),)

          ],
        ),
      ),
    );
  }
}
