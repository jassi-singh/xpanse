import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:xpanse/features/authentication/domain/usecases/signup.dart';

import '../usecases/login.dart';

abstract class AuthenticationRepo {
  Future<Either<Exception, Session>> getCurrentSession();
  Future<Either<Exception, Account>> signup(SignupParams params);
  Future<Either<Exception, Session>> login(LoginParams params);
  Future<Either<Exception, bool>> logout();
}
