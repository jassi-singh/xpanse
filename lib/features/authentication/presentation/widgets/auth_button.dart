import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:xpense/core/widgets/app_button.dart';
import 'package:xpense/features/authentication/domain/usecases/signup.dart';

import '../../domain/usecases/login.dart';
import '../bloc/authentication_bloc.dart';

class AuthButton extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const AuthButton(this.formKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final isLogin =
            state is UnauthorizedState && state.type == UnauthorizedType.login;
        final isLoading = state is UnauthorizedState && state.isLoading;

        return AppButton(
          onPressed: isLoading
              ? null
              : () {
                  if (formKey.currentState!.saveAndValidate()) {
                    context.read<AuthenticationBloc>().add(
                          isLogin
                              ? LoginEvent(
                                  LoginParams.fromMap(
                                    formKey.currentState!.value,
                                  ),
                                )
                              : SignupEvent(
                                  SignupParams.fromMap(
                                    formKey.currentState!.value,
                                  ),
                                ),
                        );
                  }
                },
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  isLogin ? 'LOGIN' : 'SIGN UP',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
        );
      },
    );
  }
}
