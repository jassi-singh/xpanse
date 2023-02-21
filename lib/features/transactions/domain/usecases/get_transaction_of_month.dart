import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:xpanse/core/usecase/usecase.dart';

import '../entities/transaction.dart';
import '../repositories/transaction_repo.dart';

class GetTransactionsBetweenTwoDates extends UseCase<List<Transaction>, TransactionOfMonthParams> {
  final TransactionRepo _repository;

  GetTransactionsBetweenTwoDates(this._repository);

  @override
  Future<Either<Exception, List<Transaction>>> call(TransactionOfMonthParams params) async {
    return await _repository.getTransactionsBetweenTwoDates(params.startDate, params.endDate);
  }
}

class TransactionOfMonthParams {
  final DateTime startDate;
  final DateTime endDate;

  TransactionOfMonthParams(this.startDate, this.endDate);
}