import 'package:flutter/material.dart';
import 'package:firebase_chat/theme/app_colors.dart';

class RoundedPasswordInputField extends StatefulWidget {
  final FormFieldValidator<String> validator;
  final FormFieldValidator<String> onChanged;

  final TextInputAction inputAction;
  final String hintText;
  final TextEditingController controller;

  const RoundedPasswordInputField({
    Key? key,
    required this.inputAction,
    required this.validator,
    required this.onChanged,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  _RoundedPasswordInputFieldState createState() =>
      _RoundedPasswordInputFieldState();
}

class _RoundedPasswordInputFieldState extends State<RoundedPasswordInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textInputAction: widget.inputAction,
      obscureText: _obscureText,
      cursorColor: white,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: const TextStyle(
          fontSize: 14,color: white,fontFamily: 'Poppins'
      ),
      decoration: inputDecoration(widget.hintText, Icons.person),
    );
  }

  InputDecoration inputDecoration(String labelText, IconData iconData,
      {String? prefix, String? helperText}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      helperText: helperText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white,fontFamily: 'Poppins'),
      fillColor: primaryColor,
      filled: true,
      prefixText: prefix,
      suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: white)),
      prefixIconConstraints: const BoxConstraints(minWidth: 60),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black)),
    );
  }
}

