import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpanse/core/widgets/app_button.dart';

import '../../../authentication/presentation/bloc/authentication_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButton(
          onPressed: () {
            context.read<AuthenticationBloc>().add(LogoutEvent());
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
