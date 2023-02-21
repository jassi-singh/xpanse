import 'package:fpdart/fpdart.dart';

import '../entities/transaction.dart';

abstract class TransactionRepo {
  Future<Either<Exception, List<Transaction>>> getTransactionsBetweenTwoDates(
    DateTime startDate,
    DateTime endDate,
  );

  Future<Either<Exception, Transaction>> addTransaction(
      Transaction transaction);

  Future<Either<Exception, Transaction>> updateTransaction(
      Transaction transaction);

  Future<Either<Exception, void>> deleteTransaction(String id);
}
