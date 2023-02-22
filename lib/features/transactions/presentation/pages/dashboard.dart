import 'package:flutter/material.dart';
import 'package:xpense/core/constants/colors.dart';
import 'package:xpense/core/widgets/app_logo.dart';

import '../widgets/month_selector/month_selector.dart';
import '../widgets/summary/summary_box.dart';
import '../widgets/transaction_list/transaction_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         AppButton(
    //           onPressed: () {
    //             context.read<AuthenticationBloc>().add(LogoutEvent());
    //           },
    //           child: const Text('Logout'),
    //         ),
    //         const SizedBox(height: 20),
    //         AppButton(
    //           onPressed: () {
    //             context
    //                 .read<TransactionsBloc>()
    //                 .add(const GetTransactionsOfMonthEvent(2, 2023));
    //           },
    //           child: const Text('Get Transactions'),
    //         ),
    //         const SizedBox(height: 20),
    //         AppButton(
    //           onPressed: () {
    //             context.read<TransactionsBloc>().add(
    //                   AddOrUpdateTransactionEvent(
    //                     transaction: Transaction.fromJson(
    //                       {
    //                         "amount": 20,
    //                         "title": "Test",
    //                         "date": DateTime.now().toString(),
    //                         "category":
    //                             CategoryEnum.food.toString().split('.').last,
    //                         "type": TransactionType.expense
    //                             .toString()
    //                             .split('.')
    //                             .last,
    //                         "userId": "63f3996d95c213cb99b4",
    //                       },
    //                     ),
    //                   ),
    //                 );
    //           },
    //           child: const Text('Add New Transactions'),
    //         ),
    //         const SizedBox(height: 20),
    //         AppButton(
    //           onPressed: () {
    //             context.read<TransactionsBloc>().add(
    //                 const DeleteTransactionEvent(id: "63f43e7476ec485fdefb"));
    //           },
    //           child: const Text('Delete Transactions'),
    //         ),
    //         const SizedBox(height: 20),
    //         AppButton(
    //           onPressed: () {
    //             context.read<TransactionsBloc>().add(
    //                   AddOrUpdateTransactionEvent(
    //                     transaction: Transaction.fromJson(
    //                       {
    //                         '\$id': "63f43aac0522e08f7631",
    //                         "amount": 50,
    //                         "title": "Test",
    //                         "date": DateTime.now().toString(),
    //                         "category":
    //                             CategoryEnum.food.toString().split('.').last,
    //                         "type": TransactionType.expense
    //                             .toString()
    //                             .split('.')
    //                             .last,
    //                         "userId": "63f3996d95c213cb99b4",
    //                       },
    //                     ),
    //                   ),
    //                 );
    //           },
    //           child: const Text('Update Transactions'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leadingWidth: 90,
        leading: const AppLogo(
          padding: 0,
          size: 40,
        ),
        centerTitle: false,
        title: const Text(
          'Xpense',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            MonthSelector(),
            SizedBox(height: 40),
            SummaryBox(),
            SizedBox(height: 20),
            TransactionsList(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
