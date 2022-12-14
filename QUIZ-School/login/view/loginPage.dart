import 'package:firebase_chat/theme/ui_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat/customerWidget/boldTextView.dart';
import 'package:firebase_chat/customerWidget/loading.dart';
import 'package:firebase_chat/customerWidget/rounded_button.dart';
import '../../customerWidget/input_form_field.dart';
import '../../customerWidget/rounded_password_input_field.dart';
import '../controller/loginController.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  static const routeName="/loginPage";
  final GlobalKey<FormState> formKey = GlobalKey();
  final loginController=Get.put(LoginController());
  final mobileController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/splash.png"),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          padding: const EdgeInsets.all(24),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BoldTextView(text: 'Enter your details',textAlign: TextAlign.center,textSize: 21,color: Colors.white,),
                      const SizedBox(height: 50,),
                      const SizedBox(height: 30,),
                      _buildMobileNumber(),
                      const SizedBox(height: 30,),
                      _buildPassword(),
                      const SizedBox(height: 30),
                      RoundedButton(text: 'Login', press: (){
                        if(formKey.currentState!.validate()){
                          loginController.loginUser(mobileController.text.toString().trim(),
                              passwordController.text.toString().trim(), context);
                        }
                      }),
                      Obx(()=>loginController.isLoading.value?const Loading():const SizedBox())
                    ],
                  ),
                ),
              )
            ],
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
      hintText: 'Email address',
      maxLength: 50,
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please enter email Id';
        }
        else if (!UiHelper.isEmail(value)) {
          return 'Please enter email Id';
        }
        else {
          return null;
        }
      },
    );
  }

  Widget _buildPassword() {
    return RoundedPasswordInputField(
      controller: passwordController,
      inputAction: TextInputAction.done,
      hintText: 'Password',
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please enter password';
        } else {
          return null;
        }
      }, onChanged: (String? value) {  },
    );
  }


}
