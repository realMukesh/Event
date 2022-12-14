import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:inventery/customerWidget/boldTextView.dart';
import 'package:inventery/customerWidget/loading.dart';
import 'package:inventery/customerWidget/regularTextView.dart';
import 'package:inventery/customerWidget/rounded_button.dart';
import 'package:inventery/customerWidget/toolbarTitle.dart';
import 'package:inventery/dashboard/controller/dashboard_controller.dart';
import 'package:inventery/theme/app_colors.dart';
import 'package:inventery/theme/strings.dart';
import 'package:inventery/theme/ui_helper.dart';

import '../../common_controller/authentication_manager.dart';
import '../../customerWidget/input_form_field.dart';
import '../controller/loginController.dart';

class OnineRegistrationPage extends GetView<DashboardController> {
  OnineRegistrationPage({Key? key}) : super(key: key);

  static const routeName = "/registration";
  final GlobalKey<FormState> formKey = GlobalKey();
  final nameController = TextEditingController();
  final tableNumberController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final desgnationeController = TextEditingController();
  final companyController = TextEditingController();
  var selectedCategory="".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        centerTitle: false,
        title: ToolbarTitle(
          title: "Onsite Registration",
        ),
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 70,
      ),
      body: Container(
        color: white,
        height: context.height,
        padding: EdgeInsets.all(24),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                _buildName(),
                const SizedBox(height: 30),
                _buildMobileNumber(),
                const SizedBox(height: 30),
                _buildDesignation(),
                const SizedBox(height: 30),
                _buildCompany(),
                const SizedBox(height: 30),
                _buildTableNumber(),
                const SizedBox(height: 30),
                RoundedButton(
                    text: "Submit",
                    press: () async {
                      //controller.onlineRegistration({}, context);
                      if (formKey.currentState!.validate()) {
                        var jsonBody = {
                          "name": nameController.text.toString().trim(),
                          "phone": mobileController.text.toString().trim(),
                          "designation": desgnationeController.text.toString().trim(),
                          "company":companyController.text.toString().trim(),
                          "table_number": tableNumberController.text.isNotEmpty?tableNumberController.text.toString().trim():"",
                        };
                        controller.onlineRegistration(jsonBody, context);
                      }
                    }),
                Obx(() =>
                    controller.isLoading.value ? const Loading() : SizedBox())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNumber() {
    return InputBorderFormField(
      controller: mobileController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.number,
      hintText: 'Mobile Number',
      maxLength: 50,
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please enter mobile number';
        }
        if (!UiHelper.isValidPhoneNumber(value)) {
          return 'Please enter valid mobile number';
        } else {
          return null;
        }
      },
    );
  }

  Widget _selectCategory(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _modalBottomSheetMenu(context);
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          border: Border.all(color: grayColorLight,width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white
        ),
        child: ListTile(
          title: Obx(()=>RegularTextView(text: selectedCategory.value.isNotEmpty?selectedCategory.value:"Select Category",textAlign: TextAlign.start,)),
        ),),
    );
  }

  Widget _buildTableNumber() {
    return InputBorderFormField(
      controller: tableNumberController,
      inputAction: TextInputAction.done,
      inputType: TextInputType.number,
      hintText: 'Table Number',
      maxLength: 50,
      validator: (String? value) {
      },
    );
  }

  Widget _buildName() {
    return InputBorderFormField(
      controller: nameController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.text,
      hintText: 'Name',
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

  Widget _buildDesignation() {
    return InputBorderFormField(
      controller: desgnationeController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.text,
      hintText: 'Designation',
      maxLength: 50,
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please enter designation';
        } else {
          return null;
        }
      },
    );
  }
  Widget _buildCompany() {
    return InputBorderFormField(
      controller: companyController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.text,
      hintText: 'Company',
      maxLength: 50,
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please enter company';
        } else {
          return null;
        }
      },

    );
  }

  Widget _buildEmail() {
    return InputBorderFormField(
      controller: emailController,
      inputAction: TextInputAction.done,
      inputType: TextInputType.emailAddress,
      hintText: 'Email Address',
      maxLength: 50,
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please enter Email Address';
        } else if (!UiHelper.isEmail(value)) {
          return 'Please enter valid email ID';
        } else {
          return null;
        }
      },
    );
  }

  void _modalBottomSheetMenu(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return Container(
            height: 200.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: ListView.builder(
                    itemCount: controller.authManager.categoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          selectedCategory(controller.authManager.categoryList[index]);
                          Get.back();
                        },
                        child: ListTile(
                            title: Text(controller.authManager.categoryList[index])),
                      );
                    }),),
          );
        }
    );
  }
}
