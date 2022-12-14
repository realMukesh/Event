import 'package:firebase_chat/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFormField extends StatelessWidget {
  final String hintText;
  final bool isMobile;
  final int maxLength;
  final IconData icon;
  final String inputExperssion;
  final TextInputType inputType;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;

  const InputFormField({
    Key? key,
    this.inputExperssion = "",
    this.isMobile = false,
    required this.controller,
    required this.inputAction,
    required this.inputType,
    required this.hintText,
    this.maxLength=50,
    this.icon = Icons.person,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: inputAction,
      keyboardType: inputType,
      validator: validator,
      style: TextStyle(
        fontSize: isMobile?14:14,color: white,fontFamily: 'Poppins'
      ),
      cursorColor: white,
      decoration: inputDecoration(hintText),
    );
  }
  InputDecoration inputDecoration(String labelText,
      {String? prefix, String? helperText}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      helperText: helperText,
      labelText: labelText,
      labelStyle: const TextStyle(color: hintColor,fontFamily: 'Poppins',fontSize: 14),
      fillColor: primaryColor,
      filled: true,
      prefixText: prefix,
      errorStyle: TextStyle(
        fontSize: 16.0,color: white,fontFamily: 'Poppins'
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 60),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

          borderSide: const BorderSide(color: primaryColor)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor)),
    );
  }
}