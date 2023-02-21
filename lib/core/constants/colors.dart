import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFF03012c);
  static const MaterialAccentColor primaryColor = Colors.indigoAccent;

  static LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryColor[100]!,
      primaryColor[400]!,
    ],
  );

  static LinearGradient blackTransparentGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryColor,
      primaryColor,
    ],
  );

  static BoxShadow primaryShadow = BoxShadow(
    color: primaryColor[100]!.withOpacity(0.5),
    offset: const Offset(5, 5),
    blurRadius: 10,
  );
}
