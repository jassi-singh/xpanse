import 'package:appwrite/models.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/authentication_repo.dart';

class Signup implements UseCase<Account, SignupParams> {
  final AuthenticationRepo _repository;

  Signup(this._repository);

  @override
  Future<Either<Exception, Account>> call(SignupParams params) async {
    return await _repository.signup(params);
  }
}

class SignupParams extends Equatable {
  final String email;
  final String password;
  final String name;

  const SignupParams({
    required this.email,
    required this.password,
    required this.name,
  });

  const SignupParams.empty()
      : email = '',
        password = '',
        name = '';

  SignupParams.fromMap(Map<String, dynamic> map)
      : email = map['email'] ?? '',
        password = map['password'] ?? '',
        name = map['name'] ?? '';

  @override
  List<Object?> get props => [email, password, name];
}
