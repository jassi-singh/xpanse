import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../bloc/authentication_bloc.dart';
import 'auth_button.dart';

class AuthForm extends StatelessWidget {
  AuthForm({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      onChanged: () {
        _formKey.currentState!.save();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocSelector<AuthenticationBloc, AuthenticationState, bool>(
            selector: (state) {
              return (state is UnauthorizedState)
                  ? state.type == UnauthorizedType.login
                  : false;
            },
            builder: ((context, isLogin) {
              if (!isLogin) {
                return FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    icon: Icon(Icons.person),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ),
          const SizedBox(
            height: 12.0,
          ),
          FormBuilderTextField(
            name: 'email',
            decoration: const InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.email),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          BlocSelector<AuthenticationBloc, AuthenticationState, bool>(
            selector: (state) {
              return state is UnauthorizedState ? state.showPassword : false;
            },
            builder: (context, showPassword) {
              return FormBuilderTextField(
                name: 'password',
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: const Icon(Icons.key),
                  suffixIcon: IconButton(
                    onPressed: () => context
                        .read<AuthenticationBloc>()
                        .add(TogglePasswordVisibilityEvent()),
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 50.0,
          ),
          AuthButton(_formKey),
        ],
      ),
    );
  }
}
