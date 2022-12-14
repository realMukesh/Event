import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_chat/theme/app_colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String lableText;
  final bool isMobile;
  final bool? enable;
  final int maxLength;
  final IconData icon;
  final String inputExperssion;
  final TextInputType inputType;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;
  final ValueChanged<String>? valueChanged;

  const RoundedInputField({
    Key? key,
    this.inputExperssion = "",
    this.isMobile = false,
    this.enable=true,
    required this.controller,
    required this.inputAction,
    required this.inputType,
    required this.hintText,
    this.lableText="",
    this.maxLength=50,
    this.icon = Icons.person,
    required this.validator,
    this.valueChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      controller: controller,
      textInputAction: inputAction,
      keyboardType: inputType,
      validator: validator,
      onChanged: valueChanged,
      maxLength: maxLength,
      inputFormatters:inputExperssion.isNotEmpty?[ FilteringTextInputFormatter.allow(RegExp(inputExperssion)),]:
      [ FilteringTextInputFormatter.allow(RegExp("[()a-zA-Z 0123456789@]")),],
      style: TextStyle(
        fontSize: 14
      ),
      cursorColor: primaryColor,
      decoration: inputDecoration(lableText,hintText),
    );
  }
  InputDecoration inputDecoration(String labelText,String hintTxt,
      {String? prefix, String? helperText}) {
    return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(isMobile?60:15, 15, 15, 15),
      helperText: helperText,
      labelText: labelText,
      hintText: hintTxt,
      labelStyle: TextStyle(color: tab_selected_color),
      fillColor: Colors.transparent,
      filled: true,
      prefixText: prefix,
      prefixIconConstraints: BoxConstraints(minWidth: 60),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black)),
    );
  }
}