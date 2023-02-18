import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFF03012c);
  static const MaterialAccentColor primaryColor = Colors.indigoAccent;

  
  static LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.primaryColor[100]!,
      AppColors.primaryColor[400]!,
    ],
  );
}
