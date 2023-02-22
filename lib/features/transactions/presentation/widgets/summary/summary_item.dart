import 'package:flutter/material.dart';
import 'package:xpense/core/extensions/string_extensions.dart';

import '../../../domain/entities/enums.dart';

class SummaryItem extends StatelessWidget {
  final TransactionType type;
  final double amount;
  const SummaryItem({
    Key? key,
    required this.type,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(type.icon),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            '${type.operation} ₹${amount.toStringAsFixed(2)}',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: type.color),
          ),
        ),
        Text(type.name.capitalize),
      ],
    );
  }
}
