import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_chat/theme/app_colors.dart';

import 'boldTextView.dart';
class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double textSize;
  final double height;
  final bool showIcon;
  final FontWeight weight;

  const RoundedButton(
      {Key? key,
        required this.text,
        required this.press,
        this.color = white,
        this.textColor = kPrimaryColor,
        this.textSize = 20,
        this.showIcon = false,
        this.height = 60,
        this.weight = FontWeight.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: size.width,
      height: height,
      child: MaterialButton(
          animationDuration: const Duration(seconds: 1),
          color: color,
          hoverColor: focusColor,
          splashColor: focusColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            Future.delayed(Duration.zero, () async {
              press();
            });
          },
          child: BoldTextView(
            text: text,
            color: textColor,
            textSize: textSize,weight: FontWeight.w400,
            /*weight: weight,*/
          )),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double textSize;
  final double height;
  final bool showIcon;
  final FontWeight weight;

  const ProfileButton(
      {Key? key,
        required this.text,
        required this.press,
        this.color = primaryColor,
        this.textColor = Colors.white,
        this.textSize = 20,
        this.showIcon = false,
        this.height = 45,
        this.weight = FontWeight.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: 120,
      height: height,
      child: MaterialButton(
          animationDuration: const Duration(seconds: 1),
          color: color,
          hoverColor: focusColor,
          splashColor: focusColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            Future.delayed(Duration.zero, () async {
              press();
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BoldTextView(
                text: text,
                color: textColor,
                textSize: textSize,weight: FontWeight.w400,
              ),
              const Icon(Icons.arrow_forward_ios,size: 13,color: Colors.white,)
            ],
          )),
    );
  }
}

class MyRoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double textSize;
  final double height;
  final bool showIcon;
  final FontWeight weight;

  const MyRoundedButton(
      {Key? key,
        required this.text,
        required this.press,
        this.color = primaryColor,
        this.textColor = Colors.white,
        this.textSize = 14,
        this.showIcon = false,
        this.height = 55,
        this.weight = FontWeight.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
        animationDuration: const Duration(seconds: 1),
        color: color,
        hoverColor: focusColor,
        splashColor: focusColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          Future.delayed(Duration.zero, () async {
            press();
          });
        },
        child: BoldTextView(
          text: text,
          color: textColor,
          textSize: textSize,weight: FontWeight.w400,
          /*weight: weight,*/
        ));
  }
}
