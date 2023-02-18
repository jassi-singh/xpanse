import 'package:flutter/material.dart';
import 'package:xpanse/features/authentication/presentation/widgets/app_logo.dart';

import '../widgets/auth_form.dart';
import '../widgets/bottom_text.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(48.0),
                  child: AppLogo(size: 80),
                ),
                AuthForm(),
                const SizedBox(
                  height: 30,
                ),
                const BottomText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
