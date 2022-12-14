import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:inventery/customerWidget/boldTextView.dart';
import 'package:inventery/routes/my_constant.dart';
import 'package:inventery/theme/strings.dart';
import 'package:lottie/lottie.dart';
import '../customerWidget/regularTextView.dart';
import 'app_colors.dart';

class UiHelper {

  static bool isNumber(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  static Future<ui.Image> bytesToImage(Uint8List imgBytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  static bool isEmail(String string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return true;
    }
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  static showDialog() {
    Get.dialog(AlertDialog(
      title: const Text('Alert'),
      content: const Text('Please login to acces this features of app.'),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Get.back(),
        ),
        TextButton(
          child: const Text("Login"),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    ));
  }

  static Future<bool> showAnimatedAlert({message,buttonText}) async {
    var response = await Get.dialog(AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/success.json', width: 100),
          Text(message)
        ],
      ),
      actions: [
        MaterialButton(
          animationDuration: Duration(seconds: 1),
          color: primaryColor,
          hoverColor: focusColor,
          splashColor: focusColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            Get.back(result: true);
          },
          child: RegularTextView(
            text: buttonText,
            color: Colors.white,
          ),
        )
      ],
    ));
    return response;
  }

  static Future<bool> showAlertDialog({title, message, yes, no}) async {
    var response = await Get.dialog(AlertDialog(
      title: BoldTextView(text: MyStrings.crosspoles,textSize: 28,),
      content: RegularTextView(text: message,),
      actions: [
        TextButton(
          child: RegularTextView(text: no,),
          onPressed: () {
            Get.back(result: false);
          },
        ),
        TextButton(
          child: RegularTextView(text: yes,),
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ],
    ));
    return response;
  }



  static Widget getLoadingImage({imageUrl}) {
    print("image url-> $imageUrl");
    return imageUrl==null || imageUrl.toString().isEmpty?Image.asset('assets/no_pic.png'):Image.network(
      imageUrl==null || imageUrl.toString().isEmpty?MyConstant.banner_image:imageUrl,
      fit: BoxFit.contain,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );


    return Image.network(
      imageUrl==null || imageUrl.toString().isEmpty?MyConstant.banner_image:imageUrl,
      fit: BoxFit.contain,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }

  static bool isValidPhoneNumber(String string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty || string.length < 7) {
      return false;
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  static int firstDayOffset(
      int year, int month, MaterialLocalizations localizations) {
    // 0-based day of week for the month and year, with 0 representing Monday.
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;

    // 0-based start of week depending on the locale, with 0 representing Sunday.
    int firstDayOfWeekIndex = localizations.firstDayOfWeekIndex;

    // firstDayOfWeekIndex recomputed to be Monday-based, in order to compare with
    // weekdayFromMonday.
    firstDayOfWeekIndex = (firstDayOfWeekIndex - 1) % 7;

    // Number of days between the first day of week appearing on the calendar,
    // and the day corresponding to the first of the month.
    return (weekdayFromMonday - firstDayOfWeekIndex) % 7;
  }

  static bool isValidName(String string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty || string.length < 2) {
      return false;
    }
    return true;
  }

  static bool isValidPasswords(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool isValidPassword(String string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty || string.length < 8) {
      return false;
    }
    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v

    return true;
  }

  static void showSnakbarMsg(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    ));
  }

  static void showSnakbarSucess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
    ));
  }

  static String formatedAmount(dynamic amount) {
    return double.parse(amount.toString()).toStringAsFixed(1).toString();
  }

  static bool isMobileValid(String phone) {
    if (phone.isEmpty || phone == null) {
      return false;
    } else if (!isValidPhoneNumber(phone)) {
      return false;
    } else {
      return true;
    }
  }
}
