import 'package:appwrite/models.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/authentication_repo.dart';

class Login implements UseCase<Session, LoginParams> {
  final AuthenticationRepo repository;

  Login(this.repository);

  @override
  Future<Either<Exception, Session>> call(LoginParams params) async {
    return await repository.login(params);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  const LoginParams.empty()
      : email = '',
        password = '';

  LoginParams.fromMap(Map<String, dynamic> map)
      : email = map['email'] ?? '',
        password = map['password'] ?? '';

  @override
  List<Object?> get props => [email, password];
}
