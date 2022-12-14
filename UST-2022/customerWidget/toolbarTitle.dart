
import 'package:flutter/material.dart';
import 'package:inventery/customerWidget/regularTextView.dart';
import 'boldTextView.dart';

class ToolbarTitle extends StatelessWidget {
  final String title;
  final Color color;
  const ToolbarTitle({
    Key? key,
    required this.title,
    this.color=Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BoldTextView(text: title,color:color,textSize: 18,textAlign: TextAlign.center);
  }
}

