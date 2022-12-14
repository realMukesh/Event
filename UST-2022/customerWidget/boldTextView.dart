import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventery/theme/app_colors.dart';


class BoldTextView extends StatelessWidget {
  final String text;
  final Color color;
  final double textSize;
  final bool underline;
  final bool centerUnderline;
  final FontStyle fontStyle;
  final TextAlign textAlign;
  final FontWeight weight;


  const BoldTextView({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.textSize = 14,
    this.underline=false,
    this.centerUnderline=false,
    this.fontStyle=FontStyle.normal,
    this.textAlign=TextAlign.center,
    this.weight=FontWeight.bold
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Text(text,textAlign: textAlign,softWrap: false,
        overflow: TextOverflow.fade,
        maxLines:2,style: TextStyle(color: color,fontWeight: weight,fontStyle: fontStyle,fontFamily: 'Poppins',fontSize: textSize,decoration: underline?TextDecoration.underline:centerUnderline?TextDecoration.overline:TextDecoration.none));
  }
}

class BoldTextViewSingleline extends StatelessWidget {
  final String text;
  final Color color;
  final double textSize;
  final bool underline;
  final bool centerUnderline;
  final FontStyle fontStyle;


  const BoldTextViewSingleline({
    Key? key,
    required this.text,
    this.color = kPrimaryColor,
    this.textSize = 17,
    this.underline=false,
    this.centerUnderline=false,
    this.fontStyle=FontStyle.normal,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Text(text, overflow: TextOverflow.ellipsis,style: TextStyle(color: color,fontWeight: FontWeight.bold,fontStyle: fontStyle,fontFamily: 'Poppins'
        ,fontSize: textSize,decoration: underline?TextDecoration.underline:centerUnderline?TextDecoration.overline:TextDecoration.none));
  }
}
