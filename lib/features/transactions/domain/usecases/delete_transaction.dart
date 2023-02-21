import 'package:fpdart/fpdart.dart';
import 'package:xpanse/core/usecase/usecase.dart';
import 'package:xpanse/features/transactions/domain/entities/transaction.dart';

import '../repositories/transaction_repo.dart';

class DeleteTransaction extends UseCase<void, String> {
  final TransactionRepo _repository;

  DeleteTransaction(this._repository);

  @override
  Future<Either<Exception, void>> call(String params) {
    return _repository.deleteTransaction(params);
  }
}
