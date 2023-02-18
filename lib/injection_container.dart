import 'package:appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';
import 'package:xpanse/core/util/helpers.dart';
import 'package:xpanse/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:xpanse/features/authentication/domain/usecases/get_current_session.dart';
import 'package:xpanse/features/authentication/domain/usecases/logout.dart';
import 'package:xpanse/features/authentication/presentation/bloc/authentication_bloc.dart';

import 'features/authentication/data/datasources/remote_datasource.dart';
import 'features/authentication/data/repositories/authentication_repo_impl.dart';
import 'features/authentication/domain/usecases/login.dart';
import 'features/authentication/domain/usecases/signup.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Authentication
  // Bloc
  sl.registerFactory(() => AuthenticationBloc(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => Signup(sl()));
  sl.registerLazySingleton(() => GetCurrentSession(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  // Repository
  sl.registerLazySingleton<AuthenticationRepo>(
    () => AuthenticationRepoImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AppwriteRemoteDataSource>(
      () => AppwriteRemoteDataSourceImpl(sl()));

  //! Core
  sl.registerLazySingleton(() => AppHelper());

  //! External
  sl.registerLazySingleton(
    () => Client()
        .setEndpoint('https://localhost/v1') // Your Appwrite Endpoint
        .setProject('63ef54e43b7d32c552eb') // Your project ID
        .setSelfSigned(status: true),
  );
  sl.registerLazySingleton(() => Account(sl()));
}
