import 'package:flutter/material.dart';
import 'package:firebase_chat/customerWidget/regularTextView.dart';
import 'package:firebase_chat/theme/app_colors.dart';

class RoundedOutlineButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double textSize;
  final bool showIcon;
  const RoundedOutlineButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = primaryColor,
    this.textColor = white,
    this.textSize=14,
    this.showIcon=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: size.width,
      height: 55,
      child: OutlinedButton(
          child: RegularTextView(text: text,color: textColor,textSize: textSize,),
          style: OutlinedButton.styleFrom(
            primary: color,
            backgroundColor: color,
            side: BorderSide(color: textColor, width: 1),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          onPressed: (){
            Future.delayed(Duration.zero, () async {
              press();
            });
          }
      ),
    );
  }
}

class MyOutlineButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double textSize;
  final bool showIcon;
  const MyOutlineButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = primaryColor,
    this.textColor = primaryColor,
    this.textSize=14,
    this.showIcon=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OutlinedButton(
        child: RegularTextView(text: text,color: textColor,textSize: textSize,),
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.white,
          side: BorderSide(color: color, width: 1),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: (){
          Future.delayed(Duration.zero, () async {
            press();
          });
        }
    );
  }
}
