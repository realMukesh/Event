import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/boldTextView.dart';
import 'package:inventery/customerWidget/regularTextView.dart';
import 'package:inventery/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

class ConfirmDialogPage extends StatefulWidget {
  bool isSuccess = false;
  String message;
  ConfirmDialogPage({Key? key, required this.isSuccess,required this.message}) : super(key: key);


  @override
  State<ConfirmDialogPage> createState() => _ConfirmDialogPageState();
}

class _ConfirmDialogPageState extends State<ConfirmDialogPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: widget.isSuccess?success_color:fail_color,
        child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.isSuccess?Lottie.asset('assets/success.json', width: 100):Lottie.asset('assets/fail.json', width: 100),
                widget.isSuccess?RegularTextView(text: widget.message,color: white,):BoldTextView(text: widget.message,color: white,),
                const SizedBox(height: 12,),
              ],
            )),
      ),
    );
  }
}

