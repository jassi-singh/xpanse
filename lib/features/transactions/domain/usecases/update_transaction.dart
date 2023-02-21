import 'package:fpdart/fpdart.dart';
import 'package:xpanse/core/usecase/usecase.dart';
import 'package:xpanse/features/transactions/domain/entities/transaction.dart';

import '../repositories/transaction_repo.dart';

class UpdateTransaction extends UseCase<Transaction, Transaction> {
  final TransactionRepo _repository;

  UpdateTransaction(this._repository);

  @override
  Future<Either<Exception, Transaction>> call(Transaction params) {
    return _repository.updateTransaction(params);
  }
}
