
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/colors.dart';
import '../../core/widgets/app_button.dart';
import '../cubit/home_cubit.dart';

class BottomAppBarItem extends StatelessWidget {
  final IconData icon;
  final int index;
  const BottomAppBarItem({
    Key? key,
    required this.icon,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, int>(
      selector: (state) {
        return state.index;
      },
      builder: (context, state) {
        return AppButton(
          onPressed: () => context.read<HomeCubit>().changeIndex(index),
          shape: const CircleBorder(),
          backgroundColor: state != index
              ? AppColors.primaryColor
              : AppColors.backgroundColor,
          child: Icon(icon),
        );
      },
    );
  }
}
