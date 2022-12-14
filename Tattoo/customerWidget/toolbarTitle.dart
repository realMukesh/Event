
import 'package:flutter/material.dart';
import 'package:firebase_chat/customerWidget/regularTextView.dart';
import 'boldTextView.dart';

class ToolbarTitle extends StatelessWidget {
  final String title;
  final Color color;
  const ToolbarTitle({
    Key? key,
    required this.title,
    this.color=Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  RegularTextView(text: title,color:color,textSize: 20,textAlign: TextAlign.center,);
  }
}

