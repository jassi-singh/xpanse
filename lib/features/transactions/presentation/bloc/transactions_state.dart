part of 'transactions_bloc.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();  

  @override
  List<Object> get props => [];
}
class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final List<Transaction> transactions;

  const TransactionsLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}
