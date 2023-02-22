import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppLogo extends StatelessWidget {
  final double padding, size;
  const AppLogo({Key? key, this.padding = 32, this.size = 140})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Icon(
        Icons.account_balance_wallet,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
