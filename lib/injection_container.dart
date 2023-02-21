import 'package:appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';
import 'package:xpanse/core/constants/constants.dart';
import 'package:xpanse/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:xpanse/features/authentication/domain/usecases/get_current_session.dart';
import 'package:xpanse/features/authentication/domain/usecases/logout.dart';
import 'package:xpanse/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:xpanse/features/transactions/data/datasources/transaction_remote_datasource.dart';
import 'package:xpanse/features/transactions/data/repositories/transaction_repo_impl.dart';
import 'package:xpanse/features/transactions/domain/repositories/transaction_repo.dart';
import 'package:xpanse/features/transactions/domain/usecases/add_transaction.dart';
import 'package:xpanse/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:xpanse/features/transactions/domain/usecases/get_transaction_of_month.dart';
import 'package:xpanse/features/transactions/domain/usecases/update_transaction.dart';

import 'features/authentication/data/datasources/remote_datasource.dart';
import 'features/authentication/data/repositories/authentication_repo_impl.dart';
import 'features/authentication/domain/usecases/login.dart';
import 'features/authentication/domain/usecases/signup.dart';
import 'features/transactions/presentation/bloc/transactions_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //* Features - Authentication
  // Bloc
  sl.registerFactory(() => AuthenticationBloc(
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

  //* Features - Transactions
  // Bloc
  sl.registerFactory(() => TransactionsBloc(sl(), sl(), sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTransactionsBetweenTwoDates(sl()));
  sl.registerLazySingleton(() => AddTransaction(sl()));
  sl.registerLazySingleton(() => UpdateTransaction(sl()));
  sl.registerLazySingleton(() => DeleteTransaction(sl()));

  // Repository
  sl.registerLazySingleton<TransactionRepo>(() => TransactionRepoImpl(sl()));

  // Data sources
  sl.registerLazySingleton<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl(sl()));

  //! Core

  //! External
  sl.registerLazySingleton(
    () => Client()
        .setEndpoint(AppConstants.appwriteEndpoint) // Your Appwrite Endpoint
        .setProject(AppConstants.appwriteProjectId) // Your project ID
        .setSelfSigned(status: true),
  );
  sl.registerLazySingleton(() => Account(sl()));
  sl.registerLazySingleton(() => Databases(sl()));
}
