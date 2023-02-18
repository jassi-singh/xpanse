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
    try {
      final user = await _remoteDataSource.signup(params);
      return Right(user);
    } on appwrite.AppwriteException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Session>> getCurrentSession() async {
    try {
      final session = await _remoteDataSource.getCurrentSession();
      return Right(session);
    } on appwrite.AppwriteException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Session>> login(LoginParams params) async {
    try {
      final session = await _remoteDataSource.login(params);
      return Right(session);
    } on appwrite.AppwriteException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, bool>> logout() async {
    try {
       await _remoteDataSource.logout();
      return const Right(true);
    } on appwrite.AppwriteException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
