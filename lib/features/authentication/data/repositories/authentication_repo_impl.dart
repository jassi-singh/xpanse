import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:xpanse/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:xpanse/features/authentication/domain/usecases/login.dart';
import 'package:xpanse/features/authentication/domain/usecases/signup.dart';

import '../datasources/remote_datasource.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final AppwriteRemoteDataSource _remoteDataSource;

  AuthenticationRepoImpl(this._remoteDataSource);
  @override
  Future<Either<Exception, Account>> signup(SignupParams params) async {
    return await _failureOrSuccess<Account>(_remoteDataSource.signup(params));
  }

  @override
  Future<Either<Exception, Session>> getCurrentSession() async {
    return await _failureOrSuccess<Session>(
        _remoteDataSource.getCurrentSession());
  }

  @override
  Future<Either<Exception, Session>> login(LoginParams params) async {
    return await _failureOrSuccess<Session>(_remoteDataSource.login(params));
  }

  @override
  Future<Either<Exception, bool>> logout() async {
    return await _failureOrSuccess<bool>(_remoteDataSource.logout());
  }

  Future<Either<Exception, T>> _failureOrSuccess<T>(Future<T> f) async {
    try {
      return Right(await f);
    } on appwrite.AppwriteException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
