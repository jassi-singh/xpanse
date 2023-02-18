import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Icon(
          Icons.account_balance_wallet,
          size: size,
          color: Colors.white,
        ),
      ),
    );
  }
}
