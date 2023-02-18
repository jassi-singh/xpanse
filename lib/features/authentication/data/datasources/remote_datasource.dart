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

  Future<void> logout();
}

class AppwriteRemoteDataSourceImpl implements AppwriteRemoteDataSource {
  final appwrite.Account _account;

  AppwriteRemoteDataSourceImpl(this._account);

  @override
  Future<Account> signup(SignupParams params) async {
    try {
      Account user = await _account.create(
        userId: appwrite.ID.unique(),
        email: params.email,
        password: params.password,
        name: params.name,
      );
      log(user.toString());
      return user;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Session> getCurrentSession() async {
    try {
      return await _account.getSession(sessionId: 'current');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Session> login(LoginParams params) {
    try {
      return _account.createEmailSession(
        email: params.email,
        password: params.password,
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (_) {
      rethrow;
    }
  }
}
