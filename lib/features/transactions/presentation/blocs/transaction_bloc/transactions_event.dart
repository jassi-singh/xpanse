part of 'transactions_bloc.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionsOfMonthEvent extends TransactionsEvent {
  final int month;
  final int year;

  const GetTransactionsOfMonthEvent(this.month, this.year);

  @override
  List<Object> get props => [month, year];
}

class DeleteTransactionEvent extends TransactionsEvent {
  final String id;

  const DeleteTransactionEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
