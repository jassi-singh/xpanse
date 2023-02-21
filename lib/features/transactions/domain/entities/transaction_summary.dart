import 'package:equatable/equatable.dart';

class TransactionSummary extends Equatable {
  final double totalIncome;
  final double totalExpense;

  const TransactionSummary({
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  List<Object?> get props => [totalIncome, totalExpense];
}
