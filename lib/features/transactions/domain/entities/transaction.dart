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
      amount: double.parse(json['amount'].toString()),
      date: DateTime.parse(json['date']),
      type: TransactionType.values
          .firstWhere((element) => element.name == json['type']),
      category: CategoryEnum.values
          .firstWhere((element) => element.name == json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '\$id': id,
      'userId': userId,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.name,
      'type': type.name,
    };
  }

  @override
  List<Object?> get props => [id, userId, title, amount, date, category];
}
