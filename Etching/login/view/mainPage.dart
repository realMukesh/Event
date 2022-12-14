import 'package:firebase_chat/theme/ui_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat/customerWidget/boldTextView.dart';
import 'package:firebase_chat/customerWidget/loading.dart';
import '../../customerWidget/input_form_field.dart';
import '../../theme/app_colors.dart';
import '../controller/database_helper.dart';
import '../controller/loginController.dart';

class MainPage extends GetView<LoginController> {
  MainPage({Key? key}) : super(key: key);

  static const routeName = "/loginPage";
  final GlobalKey<FormState> formKey = GlobalKey();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/outer_bg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/bg_inner.png'),
                          fit: BoxFit.cover))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.createCSVFile();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Image.asset(
                            "assets/logo.png",
                            height: 50,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          showIndexDialog();
                        },
                        child: const Text(
                          "Welcome",style: TextStyle(
                          fontFamily: "Brewmaster",fontSize: 50,color: white,
                        ),textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 50,

                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildName(),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildEmail(),
                      const SizedBox(height: 30),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                              onTap: () {
                                if(formKey.currentState!.validate()){
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  loginController.saveTodo(
                                      name: controller.nameController.text
                                          .toString()
                                          .trim(),
                                      email: controller.emailController.text
                                          .toString()
                                          .trim(),
                                      context: context);
                                  }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: Image.asset(
                                  "assets/print_token.png",
                                  height: 50,
                                ),
                              ))),
                    ],
                  ),
                ),
              ),
              Obx(() => loginController.isLoading.value
                  ? const Loading()
                  : const SizedBox())
            ],
          ),
        ),
        /*floatingActionButton: FloatingActionButton(
            child: Icon(Icons.delete),
            onPressed: () {
              DatabaseHelper.instance.deleteTableRecord();
            }),*/
      ),
    );
  }

  Widget _buildEmail() {
    return InputFormField(
      controller: controller.emailController,
      isMobile: false,
      inputAction: TextInputAction.done,
      inputType: TextInputType.emailAddress,
      hintText: 'Email Address',
      maxLength: 50,
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please enter email address';
        } else if (!UiHelper.isEmail(value)) {
          return 'Please enter email address';
        } else {
          return null;
        }
      },
    );
  }

  Widget _buildName() {
    return InputFormField(
      controller: controller.nameController,
      isMobile: false,
      inputAction: TextInputAction.next,
      inputType: TextInputType.name,
      hintText: 'Enter name',
      maxLength: 50,
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please enter name';
        } else {
          return null;
        }
      },
    );
  }

  void showIndexDialog() {
    Get.bottomSheet(
      Container(
          height: 150,
          color: primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        }, child: const Icon(Icons.close,size: 30,color: Colors.white,)),
                    GestureDetector(
                        onTap: () {
                          controller.authManager.setSeries(controller.seriesController.text.toString().trim());
                          Get.back();
                        }, child: const Icon(Icons.done,size: 30,color: Colors.white)),
                  ],
                ),
              ),
              const Divider(),
              InputFormField(
                controller: controller.seriesController,
                isMobile: false,
                inputAction: TextInputAction.done,
                inputType: TextInputType.number,
                hintText: 'Enter Series Number',
                maxLength: 50,
                validator: (String? value) {
                  if (value!.trim().isEmpty || value.trim() == null) {
                    return 'Please enter ';
                  }
                },
              )
            ],
          )),
      backgroundColor: Colors.red,
      barrierColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
    );
  }

  tokenPreview() {
    return Container(
        padding: const EdgeInsets.all(0.0),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/empty.png"),fit: BoxFit.contain)
        ),
        child: Center(child: Text("${"84"}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.black))));
  }
}

