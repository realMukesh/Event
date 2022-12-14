import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/boldTextView.dart';
import 'package:inventery/customerWidget/regularTextView.dart';
import 'package:inventery/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

class ConfirmDialogPage extends StatefulWidget {
  bool isSuccess = false;
  String message;
  ConfirmDialogPage({Key? key, required this.isSuccess, required this.message})
      : super(key: key);

  @override
  State<ConfirmDialogPage> createState() => _ConfirmDialogPageState();
}

class _ConfirmDialogPageState extends State<ConfirmDialogPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed( Duration(seconds: widget.isSuccess?3:6), () {
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: widget.isSuccess ? success_color : fail_color,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.isSuccess
                ? Lottie.asset('assets/success.json', width: 100)
                : Lottie.asset('assets/fail.json', width: 100),
            widget.isSuccess
                ? Text(
                    widget.message.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.center,
                  )
                : Text(widget.message.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.center),
            const SizedBox(
              height: 12,
            ),
            MaterialButton(
                animationDuration: const Duration(seconds: 1),
                color: white,
                hoverColor: button_color,
                splashColor: button_color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: widget.isSuccess
                      ? const BoldTextView(
                          text: "Ok",
                          color: success_color,
                        )
                      : const BoldTextView(
                          text: "Try Again",
                          color: fail_color,
                        ),
                ))
          ],
        )),
      ),
    );
  }
}
