import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
      //color: Colors.white.withOpacity(0.8),
    );
  }
}
