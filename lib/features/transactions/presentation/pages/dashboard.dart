import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpanse/core/widgets/app_button.dart';
import 'package:xpanse/features/transactions/domain/entities/enums.dart';
import 'package:xpanse/features/transactions/domain/entities/transaction.dart';
import 'package:xpanse/features/transactions/presentation/bloc/transactions_bloc.dart';

import '../../../authentication/presentation/bloc/authentication_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(LogoutEvent());
              },
              child: const Text('Logout'),
            ),
            const SizedBox(height: 20),
            AppButton(
              onPressed: () {
                context
                    .read<TransactionsBloc>()
                    .add(const GetTransactionsOfMonthEvent(2, 2023));
              },
              child: const Text('Get Transactions'),
            ),
            const SizedBox(height: 20),
            AppButton(
              onPressed: () {
                context.read<TransactionsBloc>().add(
                      AddOrUpdateTransactionEvent(
                        transaction: Transaction.fromJson(
                          {
                            "amount": 20,
                            "title": "Test",
                            "date": DateTime.now().toString(),
                            "category":
                                CategoryEnum.food.toString().split('.').last,
                            "type": TransactionType.expense
                                .toString()
                                .split('.')
                                .last,
                            "userId": "63f3996d95c213cb99b4",
                          },
                        ),
                      ),
                    );
              },
              child: const Text('Add New Transactions'),
            ),
            const SizedBox(height: 20),
            AppButton(
              onPressed: () {
                context.read<TransactionsBloc>().add(
                    const DeleteTransactionEvent(id: "63f43e7476ec485fdefb"));
              },
              child: const Text('Delete Transactions'),
            ),
            const SizedBox(height: 20),
            AppButton(
              onPressed: () {
                context.read<TransactionsBloc>().add(
                      AddOrUpdateTransactionEvent(
                        transaction: Transaction.fromJson(
                          {
                            '\$id': "63f43aac0522e08f7631",
                            "amount": 50,
                            "title": "Test",
                            "date": DateTime.now().toString(),
                            "category":
                                CategoryEnum.food.toString().split('.').last,
                            "type": TransactionType.expense
                                .toString()
                                .split('.')
                                .last,
                            "userId": "63f3996d95c213cb99b4",
                          },
                        ),
                      ),
                    );
              },
              child: const Text('Update Transactions'),
            ),
          ],
        ),
      ),
    );
  }
}
