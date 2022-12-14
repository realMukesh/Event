import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:inventery/customerWidget/boldTextView.dart';
import 'package:inventery/customerWidget/loading.dart';
import 'package:inventery/customerWidget/regularTextView.dart';
import 'package:inventery/customerWidget/rounded_button.dart';
import 'package:inventery/theme/app_colors.dart';
import 'package:inventery/theme/strings.dart';
import 'package:inventery/theme/ui_helper.dart';

import '../../customerWidget/input_form_field.dart';
import '../controller/loginController.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  static const routeName="/loginPage";
  final GlobalKey<FormState> formKey = GlobalKey();
  final loginController=Get.put(LoginController());
  final mobileController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        toolbarHeight: 0,
      ),
      body: Container(
        color: white,
        height: context.height,
        padding: EdgeInsets.all(24),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset('assets/logo.png',height: 30,),
                SizedBox(height: 60,),
                ListTile(
                  title: BoldTextView(text: MyStrings.sign_in,textAlign: TextAlign.start,color: black,textSize: 24,),
                  subtitle: RegularTextView(text: MyStrings.welcome_back_sign_in,textSize: 18,),
                ),
                _buildMobileNumber(),
                SizedBox(height: 30),
                RoundedButton(text: MyStrings.next, press: (){
                  if(formKey.currentState!.validate()){
                    loginController.loginUser(mobileController.text.toString(), context);
                  }

                }),
                /*Positioned(child: FloatingActionButton.extended(
                heroTag: "Login",
                backgroundColor: black,
                onPressed: (){
                  loginController.loginUser("", "", context);

                }, label: RegularTextView(text: 'Sign in with google',color: Colors.white,),icon: Image.asset('assets/google_icon.png',width: 30,),),bottom: 20,),*/
                Obx(()=>loginController.isLoading.value?Loading():SizedBox())
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildMobileNumber() {
    return InputFormField(
      controller: mobileController,
      isMobile: true,
      inputAction: TextInputAction.done,
      inputType: TextInputType.emailAddress,
      hintText: 'Mobile Number',
      maxLength: 10,
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please enter mobile number';
        }
        if (!UiHelper.isValidPhoneNumber(value)) {
          return 'Please enter valid mobile number';
        }
        else {
          return null;
        }
      },
    );
  }


}
