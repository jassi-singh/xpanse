import 'package:flutter/material.dart';
import '../../../../injection_container.dart';
import '../bloc/authentication_bloc.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sl<AuthenticationBloc>().add(CheckAuthorizationEvent());
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          AppLogo(size: 140.0),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Xpanse',
            style: TextStyle(
              fontSize: 44.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ));
  }
}