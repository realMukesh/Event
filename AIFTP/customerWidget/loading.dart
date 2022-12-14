import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
      ),
      //color: Colors.white.withOpacity(0.8),
    );
  }
}
