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
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final desgnationeController = TextEditingController();

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
                _buildName(),
                const SizedBox(height: 30),
                _buildMobileNumber(),
                const SizedBox(height: 30),
                _buildEmail(),
                const SizedBox(height: 30),
                _buildDesignation(),
                const SizedBox(height: 30),
                RoundedButton(
                    text: "Submit",
                    press: () async {
                      //controller.onlineRegistration({}, context);
                      if (formKey.currentState!.validate()) {
                        var jsonBody = {
                          "name": nameController.text.toString().trim(),
                          "email": emailController.text.toString().trim(),
                          "phone": mobileController.text.toString().trim(),
                          "designation":
                              desgnationeController.text.toString().trim(),
                        };
                       // controller.onlineRegistration(jsonBody, context);
                      }
                    }),
                Obx(() =>
                    controller.isLoading.value ? Loading() : SizedBox())
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
      inputAction: TextInputAction.done,
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

  Widget _buildName() {
    return InputBorderFormField(
      controller: nameController,
      inputAction: TextInputAction.done,
      inputType: TextInputType.text,
      hintText: 'First Name',
      maxLength: 50,
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please First Name';
        } else {
          return null;
        }
      },
    );
  }

  Widget _buildDesignation() {
    return InputBorderFormField(
      controller: desgnationeController,
      inputAction: TextInputAction.done,
      inputType: TextInputType.text,
      hintText: 'Designation',
      maxLength: 50,
      validator: (String? value) {
        if (value!.trim().isEmpty || value.trim() == null) {
          return 'Please enter Designation';
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
}
