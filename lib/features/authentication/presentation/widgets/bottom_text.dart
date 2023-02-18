import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../bloc/authentication_bloc.dart';

class BottomText extends StatelessWidget {
  const BottomText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthenticationBloc, AuthenticationState, bool>(
      selector: (state) {
        return (state is UnauthorizedState)
            ? state.type == UnauthorizedType.login
            : false;
      },
      builder: (context, isLogin) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${isLogin ? 'Don\'t' : 'Already'} have an account?'),
            TextButton(
              onPressed: () => context
                  .read<AuthenticationBloc>()
                  .add(ChangeAuthStateEvent()),
              child: Text(
                isLogin ? 'SIGN UP' : 'LOGIN',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
