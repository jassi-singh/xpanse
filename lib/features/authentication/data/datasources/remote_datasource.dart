import 'dart:developer';

import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart';
import 'package:xpanse/features/authentication/domain/usecases/login.dart';
import 'package:xpanse/features/authentication/domain/usecases/signup.dart';

abstract class AppwriteRemoteDataSource {
  /// Calls the create account endpoint from appwrite account.
  ///
  /// Throws a [AppwriteException] for all error codes.
  Future<Account> signup(SignupParams params);

  /// Get the current session of logged in user.
  ///
  /// Throws a [AppwriteException] for all error codes.
  Future<Session> getCurrentSession();

  /// Calls the login endpoint from appwrite account.
  ///
  /// Throws a [AppwriteException] for all error codes.
  Future<Session> login(LoginParams params);

  /// Calls the logout endpoint from appwrite account.
  ///
  /// Throws a [AppwriteException] for all error codes.
  Future<bool> logout();
}

class AppwriteRemoteDataSourceImpl implements AppwriteRemoteDataSource {
  final appwrite.Account _account;

  AppwriteRemoteDataSourceImpl(this._account);

  @override
  Future<Account> signup(SignupParams params) async {
    return _failureOrSuccess(
      _account.create(
        userId: appwrite.ID.unique(),
        email: params.email,
        password: params.password,
        name: params.name,
      ),
    );
  }

  @override
  Future<Session> getCurrentSession() async {
    return _failureOrSuccess<Session>(
      _account.getSession(
        sessionId: 'current',
      ),
    );
  }

  @override
  Future<Session> login(LoginParams params) {
    return _failureOrSuccess<Session>(
      _account.createEmailSession(
        email: params.email,
        password: params.password,
      ),
    );
  }

  @override
  Future<bool> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<T> _failureOrSuccess<T>(Future<T> f) async {
    try {
      return await f;
    } catch (e) {
      rethrow;
    }
  }
}
