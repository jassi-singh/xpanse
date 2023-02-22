import 'package:fpdart/fpdart.dart';
import 'package:xpense/core/util/helpers.dart';
import 'package:xpense/features/transactions/domain/entities/transaction.dart';
import 'package:xpense/features/transactions/domain/repositories/transaction_repo.dart';

import '../datasources/transaction_remote_datasource.dart';

class TransactionRepoImpl implements TransactionRepo {
  final TransactionRemoteDataSource _remoteDataSource;

  TransactionRepoImpl(this._remoteDataSource);
  @override
  Future<Either<Exception, Transaction>> addTransaction(
      Transaction transaction) async {
    return AppHelper.appwriteExceptionCatcher(() async {
      final document = await _remoteDataSource.addOrUpdateTransaction(
        transaction.toJson(),
      );

      return Transaction.fromJson(document.data);
    });
  }

  @override
  Future<Either<Exception, void>> deleteTransaction(String id) {
    return AppHelper.appwriteExceptionCatcher(
      () => _remoteDataSource.deleteTransaction(id),
    );
  }

  @override
  Future<Either<Exception, List<Transaction>>> getTransactionsBetweenTwoDates(
      DateTime startDate, DateTime endDate) async {
    return AppHelper.appwriteExceptionCatcher<List<Transaction>>(() async {
      final documentList =
          await _remoteDataSource.getTransactionsBetweenTwoDates(
        startDate,
        endDate,
        '63f3996d95c213cb99b4',
      );
      return documentList.documents
          .map((e) => Transaction.fromJson(e.data))
          .toList();
    });
  }

  @override
  Future<Either<Exception, Transaction>> updateTransaction(
      Transaction transaction) {
    return AppHelper.appwriteExceptionCatcher(
      () async {
        final document = await _remoteDataSource.addOrUpdateTransaction(
          transaction.toJson(),
          documentId: transaction.id,
        );

        return Transaction.fromJson(document.data);
      },
    );
  }
}
