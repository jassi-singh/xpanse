
import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../domain/entities/transaction.dart';
import '../../../domain/usecases/add_transaction.dart';
import '../../../domain/usecases/delete_transaction.dart';
import '../../../domain/usecases/update_transaction.dart';

part 'add_update_cubit_state.dart';

class AddUpdateCubit extends Cubit<AddUpdateState> {
  final AddTransaction _addTransaction;
  final UpdateTransaction _updateTransaction;
  final DeleteTransaction _deleteTransaction;

  AddUpdateCubit(
      this._addTransaction, this._updateTransaction, this._deleteTransaction)
      : super(const AddUpdateState(AddUpdateStatus.initial));

  Future<void> addOrUpdate(Transaction transaction) async {
    emit(const AddUpdateState(AddUpdateStatus.loading));
    Either<Exception, Transaction> res;
    if (transaction.id != null) {
      res = await _updateTransaction(transaction);
    } else {
      res = await _addTransaction(transaction);
    }

    res.fold((failure) {
      if (failure is AppwriteException) {
        emit(AddUpdateState(AddUpdateStatus.failure,
            error: failure.message.toString()));
      } else {
        emit(
            AddUpdateState(AddUpdateStatus.failure, error: failure.toString()));
      }
    }, (transaction) {
      emit(const AddUpdateState(AddUpdateStatus.success));
    });
  }

  Future<void> delete(String id) async {
    emit(const AddUpdateState(AddUpdateStatus.loading));
    final res = await _deleteTransaction(id);

    res.fold((failure) {
      if (failure is AppwriteException) {
        emit(AddUpdateState(AddUpdateStatus.failure,
            error: failure.message.toString()));
      } else {
        emit(
            AddUpdateState(AddUpdateStatus.failure, error: failure.toString()));
      }
    }, (transaction) {
      emit(const AddUpdateState(AddUpdateStatus.success));
    });
  }
}
