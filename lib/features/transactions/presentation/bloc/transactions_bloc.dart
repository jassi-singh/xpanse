import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:xpanse/features/transactions/domain/entities/enums.dart';
import 'package:xpanse/features/transactions/domain/usecases/add_transaction.dart';

import '../../../../core/util/helpers.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/get_transaction_of_month.dart';
import '../../domain/usecases/update_transaction.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetTransactionsBetweenTwoDates _getTransactionsBetweenTwoDates;
  final AddTransaction _addTransaction;
  final DeleteTransaction _deleteTransaction;
  final UpdateTransaction _updateTransaction;

  TransactionsBloc(
    this._getTransactionsBetweenTwoDates,
    this._addTransaction,
    this._deleteTransaction,
    this._updateTransaction,
  ) : super(TransactionsInitial()) {
    on<GetTransactionsOfMonthEvent>(_getTransactionsOfMonthEvent);
    on<AddOrUpdateTransactionEvent>(_addOrUpdateTransactionEvent);
    on<DeleteTransactionEvent>(_deleteTransactionEvent);
  }

  Future<FutureOr<void>> _getTransactionsOfMonthEvent(
      GetTransactionsOfMonthEvent event,
      Emitter<TransactionsState> emit) async {
    final DateTime startDate = DateTime(event.year, event.month);
    final DateTime endDate = DateTime(event.year, event.month + 1);
    final res = await _getTransactionsBetweenTwoDates(
      TransactionOfMonthParams(startDate, endDate),
    );
    res.fold((failure) {
      AppHelper.showSnackBar(
        failure is AppwriteException
            ? failure.message.toString()
            : failure.toString(),
      );
    }, (transactionList) {
      log(transactionList.length.toString());
      for (var element in transactionList) {
        log(element.toJson().toString());
      }
    });
  }

  Future<FutureOr<void>> _addOrUpdateTransactionEvent(
      AddOrUpdateTransactionEvent event,
      Emitter<TransactionsState> emit) async {
    Either<Exception, Transaction> res;
    if (event.transaction.id != null) {
      res = await _updateTransaction(event.transaction);
    } else {
      res = await _addTransaction(event.transaction);
    }

    res.fold((failure) {
      AppHelper.showSnackBar(
        failure is AppwriteException
            ? failure.message.toString()
            : failure.toString(),
      );
    }, (transaction) {
      log(transaction.toJson().toString());
    });
  }

  Future<FutureOr<void>> _deleteTransactionEvent(
      DeleteTransactionEvent event, Emitter<TransactionsState> emit) async {
    final res = await _deleteTransaction(event.id);

    res.fold((failure) {
      AppHelper.showSnackBar(
        failure is AppwriteException
            ? failure.message.toString()
            : failure.toString(),
      );
    }, (_) {
      log('Deleted Successfully');
    });
  }
}
