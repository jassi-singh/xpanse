import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class AppHelper {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static Future<T> exceptionCatcher<T>(Future<T> f) async {
    try {
      return await f;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Either<Exception, T>> appwriteExceptionCatcher<T>(
      Future<T> Function() f) async {
    try {
      return Right(await f());
    } on AppwriteException catch (e) {
      log(e.message.toString());
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(Exception(e));
    }
  }
}
