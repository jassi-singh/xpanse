import 'dart:async';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xpense/features/transactions/domain/entities/enums.dart';

import '../../../../../core/util/helpers.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/usecases/get_transaction_of_month.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetTransactionsBetweenTwoDates _getTransactionsBetweenTwoDates;

  TransactionsBloc(
    this._getTransactionsBetweenTwoDates,
  ) : super(TransactionsInitial()) {
    on<GetTransactionsOfMonthEvent>(_getTransactionsOfMonthEvent);
  }

  Future<FutureOr<void>> _getTransactionsOfMonthEvent(
      GetTransactionsOfMonthEvent event,
      Emitter<TransactionsState> emit) async {
    emit(TransactionsLoading());
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
      double expense = 0, income = 0;
      for (var e in transactionList) {
        if (e.type == TransactionType.expense) {
          expense += e.amount;
        } else {
          income += e.amount;
        }
      }
      emit(TransactionsLoaded(transactionList, expense, income));
    });
  }
}
