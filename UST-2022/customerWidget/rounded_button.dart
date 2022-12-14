import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:inventery/customerWidget/regularTextView.dart';
import 'package:inventery/theme/app_colors.dart';

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
      this.color = button_color,
      this.textColor = Colors.white,
      this.textSize = 18,
      this.showIcon = false,
      this.height = 55,
      this.weight = FontWeight.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: size.width,
      height: height,
      child: MaterialButton(
          animationDuration: Duration(seconds: 1),
          color: color,
          hoverColor: focusColor,
          splashColor: focusColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: BoldTextView(
            text: text,
            color: textColor,
            textSize: textSize,
            weight: FontWeight.w400,
            /*weight: weight,*/
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            Future.delayed(Duration.zero, () async {
              press();
            });
          }),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double height;
  final String iconPath;
  final bool showCount;
  final int count;

  const DashboardButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = primaryColor,
    this.textColor = black,
    this.height = 90,
    required this.iconPath,
    this.showCount = false,
    this.count=0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: height,
      width: context.width,
      child: MaterialButton(
          animationDuration: const Duration(seconds: 1),
          color: color,
          hoverColor: button_color,
          splashColor: button_color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            Future.delayed(Duration.zero, () async {
              press();
            });
          },
          child: Stack(
            fit: StackFit.loose,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    iconPath,
                    height: 30,
                  ),
                ),
              ),
              //Image.asset(icon,height: 35,),
              Align(
                alignment: Alignment.center,
                child: BoldTextView(
                    text: text,
                    textAlign: TextAlign.start,
                    textSize: 21,
                    weight: FontWeight.w400,
                    color: textColor),
              ),
              showCount
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.loose,
                        children: [
                          Image.asset(
                            'assets/icons/badge_bg.png',
                            width: 30,
                          ),
                          RegularTextView(
                            text: count.toString(),
                            textSize: 10,
                            color: white,
                          )
                        ],
                      ),
                    )
                  : const SizedBox()
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
  final bool clickLeft;
  final FontWeight weight;

  const MyRoundedButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color = primaryColor,
      this.textColor = Colors.white,
      this.textSize = 14,
      this.clickLeft = false,
      this.height = 55,
      this.weight = FontWeight.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
        animationDuration: Duration(seconds: 1),
        color: clickLeft?button_color:black,
        hoverColor: focusColor,
        splashColor: focusColor,
        shape: RoundedRectangleBorder(
            borderRadius: clickLeft
                ? BorderRadius.only(
                    topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))
                : BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
        child: BoldTextView(
          text: text,
          color: textColor,
          textSize: textSize,
          weight: FontWeight.w400,
          /*weight: weight,*/
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          Future.delayed(Duration.zero, () async {
            press();
          });
        });
  }
}
