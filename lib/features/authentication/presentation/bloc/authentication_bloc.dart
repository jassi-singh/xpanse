import 'dart:async';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:xpense/core/usecase/usecase.dart';
import 'package:xpense/core/util/helpers.dart';
import 'package:xpense/features/authentication/domain/usecases/get_current_session.dart';
import 'package:xpense/features/authentication/domain/usecases/signup.dart';
import 'package:xpense/features/authentication/presentation/pages/auth_screen.dart';
import 'package:xpense/home/home.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetCurrentSession _getCurrentSession;
  final Signup _signupUsecase;
  final Login _loginUsecase;
  final Logout _logoutUsecase;
  AuthenticationBloc(
    this._getCurrentSession,
    this._signupUsecase,
    this._loginUsecase,
    this._logoutUsecase,
  ) : super(const UnauthorizedState.initial()) {
    on<CheckAuthorizationEvent>(_checkAuthorization);
    on<ChangeAuthStateEvent>(_changeAuthState);
    on<SignupEvent>(_signup);
    on<TogglePasswordVisibilityEvent>(_togglePasswordVisibility);
    on<LoginEvent>(_login);
    on<LogoutEvent>(_logout);
  }

  Future<void> _checkAuthorization(
    CheckAuthorizationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    final failureOrSession = await _getCurrentSession(NoParams());
    failureOrSession.fold(
      (failure) {
        _navigate(false);
      },
      (session) {
        emit(AuthorizedState(session: session));
        _navigate(true);
      },
    );
  }

  FutureOr<void> _changeAuthState(
      ChangeAuthStateEvent event, Emitter<AuthenticationState> emit) {
    if (state is UnauthorizedState) {
      final _unAuthState = state as UnauthorizedState;
      switch (_unAuthState.type) {
        case UnauthorizedType.login:
          emit(_unAuthState.copyWith(type: UnauthorizedType.signup));
          break;
        case UnauthorizedType.signup:
          emit(_unAuthState.copyWith(type: UnauthorizedType.login));
          break;
      }
    }
  }

  Future<void> _signup(
      SignupEvent event, Emitter<AuthenticationState> emit) async {
    if (state is UnauthorizedState) {
      final _unAuthState = state as UnauthorizedState;
      if (_unAuthState.type == UnauthorizedType.signup) {
        emit(_unAuthState.copyWith(isLoading: true));
        final failureOrUser = await _signupUsecase(event.params);

        await failureOrUser.fold(
          (failure) {
            AppHelper.showSnackBar(
              failure is AppwriteException
                  ? failure.message.toString()
                  : failure.toString(),
            );
            emit(_unAuthState.copyWith(isLoading: false));
          },
          (user) async {
            AppHelper.showSnackBar('Account created successfully');
            await _login(
              LoginEvent(
                LoginParams(
                  email: event.params.email,
                  password: event.params.password,
                ),
              ),
              emit,
            );
          },
        );
      }
    }
  }

  FutureOr<void> _togglePasswordVisibility(
      TogglePasswordVisibilityEvent event, Emitter<AuthenticationState> emit) {
    final _unauthState = state as UnauthorizedState;
    emit(_unauthState.copyWith(showPassword: !_unauthState.showPassword));
  }

  FutureOr<void> _login(
      LoginEvent event, Emitter<AuthenticationState> emit) async {
    if (state is UnauthorizedState) {
      final _unAuthState = state as UnauthorizedState;
      emit(_unAuthState.copyWith(isLoading: true));
      final failureOrSession = await _loginUsecase(event.params);
      failureOrSession.fold(
        (failure) {
          AppHelper.showSnackBar(
            failure is AppwriteException
                ? failure.message.toString()
                : failure.toString(),
          );
          emit(_unAuthState.copyWith(isLoading: false));
        },
        (session) {
          emit(AuthorizedState(session: session));
          _navigate(true);
        },
      );
    }
  }

  Future<FutureOr<void>> _logout(
      LogoutEvent event, Emitter<AuthenticationState> emit) async {
    final failureOrSuccess = await _logoutUsecase(NoParams());
    failureOrSuccess.fold(
      (failure) {
        AppHelper.showSnackBar(
          failure is AppwriteException
              ? failure.message.toString()
              : failure.toString(),
        );
      },
      (success) {
        emit(const UnauthorizedState.initial());
        _navigate(false);
      },
    );
  }

  Future<dynamic> _navigate(bool success) {
    return Navigator.pushAndRemoveUntil(
      AppHelper.navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) =>
              success ? const HomeScreen() : const AuthScreen()),
      (route) => false,
    );
  }
}
