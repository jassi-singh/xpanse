import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'bottom_navigator_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.primaryColor,
      notchMargin: -4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            BottomAppBarItem(
              icon: Icons.home,
              index: 0,
            ),
            BottomAppBarItem(
              icon: Icons.search,
              index: 1,
            ),
            SizedBox(width: 48.0),
            BottomAppBarItem(
              icon: Icons.pie_chart,
              index: 2,
            ),
            BottomAppBarItem(
              icon: Icons.settings,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }
}