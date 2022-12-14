import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventery/theme/app_colors.dart';

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
      maxLength: maxLength,
      style: TextStyle(
        fontSize: isMobile?30:14,
      ),
      cursorColor: primaryColor,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          filled: true,
          hintStyle: TextStyle(color: grayColorLight,fontWeight: isMobile?FontWeight.bold:FontWeight.normal,fontFamily: 'Poppins'),
          hintText: hintText,
          fillColor: Colors.white70),
    );
  }
}

class InputFormFieldCode extends StatelessWidget {
  final String hintText;
  final bool isMobile;
  final int maxLength;
  final IconData icon;
  final String inputExperssion;
  final TextInputType inputType;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;

  const InputFormFieldCode({
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
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: grayColorLight,width: 1)
      ),
      child: Center(
        child: TextFormField(
           maxLength: maxLength,
            controller: controller,
            textInputAction: inputAction,
            keyboardType: inputType,
            validator: validator,
            inputFormatters: [LengthLimitingTextInputFormatter(50),],
            cursorColor: primaryColor,
            decoration: InputDecoration.collapsed(hintText: hintText)),
      ),
    );
  }
}

class InputBorderFormField extends StatelessWidget {
  final String hintText;
  final bool isMobile;
  final int maxLength;
  final IconData icon;
  final String inputExperssion;
  final TextInputType inputType;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;

  const InputBorderFormField({
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
          fontSize: isMobile?14:14,color: Colors.black,fontFamily: 'Poppins'
      ),
      cursorColor: Colors.black,
      decoration: inputDecoration(hintText),
    );
  }
  InputDecoration inputDecoration(String labelText,
      {String? prefix, String? helperText}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      helperText: helperText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 14),
      fillColor: Colors.white,
      filled: true,
      prefixText: prefix,
      errorStyle: TextStyle(
          fontSize: 16.0,color: Colors.red,fontFamily: 'Poppins'
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 60),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: grayColorLight)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

          borderSide: const BorderSide(color: button_color)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: grayColorLight)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red)),
    );
  }
}