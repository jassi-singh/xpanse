import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/enums.dart';
import '../../blocs/transaction_bloc/transactions_bloc.dart';
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
      child: BlocBuilder<TransactionsBloc, TransactionsState>(
        buildWhen: (previous, current) {
          if (current is TransactionsLoaded) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is TransactionsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wallet),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '₹${(state.income - state.expense).toStringAsFixed(2)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    const Text("Balance"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SummaryItem(
                      type: TransactionType.expense,
                      amount: state.expense,
                    ),
                    SummaryItem(
                      type: TransactionType.income,
                      amount: state.income,
                    ),
                  ],
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
