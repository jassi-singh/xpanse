part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthorizationEvent extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final LoginParams params;

  const LoginEvent(this.params);
}

class SignupEvent extends AuthenticationEvent {
  final SignupParams params;

  const SignupEvent(this.params);
}

class ChangeAuthStateEvent extends AuthenticationEvent {}

class TogglePasswordVisibilityEvent extends AuthenticationEvent {}
