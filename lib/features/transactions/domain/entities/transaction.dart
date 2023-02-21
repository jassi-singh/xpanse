import 'package:equatable/equatable.dart';

import 'enums.dart';

class Transaction extends Equatable {
  final String? id;
  final String userId;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final CategoryEnum category;

  const Transaction({
    this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['\$id'],
      userId: json['userId'],
      title: json['title'],
      amount: json['amount'] * 1.0,
      date: DateTime.parse(json['date']),
      type: TransactionType.values.firstWhere(
          (element) => element.toString().split('.').last == json['type']),
      category: CategoryEnum.values.firstWhere(
          (element) => element.toString().split('.').last == json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '\$id': id,
      'userId': userId,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.toString().split('.').last,
      'type': type.toString().split('.').last,
    };
  }

  @override
  List<Object?> get props => [id, userId, title, amount, date, category];
}
