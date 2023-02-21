import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final ShapeBorder shape;
  final Color? backgroundColor;

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.shape = const StadiumBorder(),
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: shape,
        gradient: backgroundColor != null ? null : AppColors.primaryGradient,
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: shape,
        visualDensity:
            const VisualDensity(vertical: VisualDensity.maximumDensity),
        child: child,
      ),
    );
  }
}
