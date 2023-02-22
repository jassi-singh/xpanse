import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpense/core/constants/colors.dart';
import 'package:xpense/core/widgets/app_button.dart';
import 'package:xpense/features/transactions/presentation/pages/dashboard.dart';

import '../features/transactions/presentation/pages/add_update_transaction.dart';
import 'cubit/home_cubit.dart';
import 'widgets/app_bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: AppButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUpdateTransaction(),
            ),
          ),
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            size: 30,
            color: AppColors.primaryColor,
          ),
        ),
        bottomNavigationBar: const AppBottomNavigationBar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            switch (state.index) {
              case 0:
                return const Dashboard();
              case 1:
                return const Placeholder();
              case 2:
                return const Placeholder();
              case 3:
                return const Placeholder();
              default:
                return const Placeholder();
            }
          },
        ),
      ),
    );
  }
}
