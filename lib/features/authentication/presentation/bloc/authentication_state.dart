part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class UnauthorizedState extends AuthenticationState {
  final UnauthorizedType type;
  final bool isLoading, showPassword;

  const UnauthorizedState({
    required this.type,
    required this.isLoading,
    required this.showPassword,
  });

  const UnauthorizedState.initial()
      : type = UnauthorizedType.login,
        isLoading = false,
        showPassword = false;

  UnauthorizedState copyWith(
      {UnauthorizedType? type, bool? isLoading, bool? showPassword}) {
    return UnauthorizedState(
      type: type ?? this.type,
      isLoading: isLoading ?? false,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  @override
  List<Object> get props => [type, isLoading, showPassword];
}

enum UnauthorizedType {
  login,
  signup,
}

class AuthorizedState extends AuthenticationState {
  final Session session;

  const AuthorizedState({required this.session});

  @override
  List<Object> get props => [session];
}
