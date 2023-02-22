import 'package:flutter/material.dart';
import 'package:xpense/core/extensions/string_extensions.dart';
import 'package:xpense/features/transactions/domain/entities/enums.dart';
import 'package:xpense/features/transactions/presentation/pages/add_update_transaction.dart';

import '../../../domain/entities/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionListItem({
    required this.transaction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddUpdateTransaction(
            transaction: transaction,
          ),
        ),
      ),
      title: Text(transaction.title),
      subtitle: Text(transaction.category.name.capitalize),
      leading: Container(
        decoration: BoxDecoration(
          color: transaction.category.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            transaction.category.icon,
            color: Colors.white,
          ),
        ),
      ),
      trailing: Text(
        '${transaction.type.operation} ₹${transaction.amount.toStringAsFixed(2)}',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: transaction.type.color,
            ),
      ),
    );
  }
}
