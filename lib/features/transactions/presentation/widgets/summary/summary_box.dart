import 'package:flutter/material.dart';

import '../../../domain/entities/enums.dart';
import 'summary_item.dart';

class SummaryBox extends StatelessWidget {
  const SummaryBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SummaryItem(
            type: TransactionType.expense,
            amount: 2000,
          ),
          SummaryItem(
            type: TransactionType.income,
            amount: 40000,
          ),
        ],
      ),
    );
  }
}
