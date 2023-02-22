import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/add_update_cubit/add_update_cubit.dart';
import '../../blocs/transaction_bloc/transactions_bloc.dart';
import '../month_selector/cubit/month_selector_cubit.dart';
import 'transaction_list_item.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        child: BlocListener<AddUpdateCubit, AddUpdateState>(
          listener: (context, state) {
            if (state.status == AddUpdateStatus.success) {
              context.read<TransactionsBloc>().add(GetTransactionsOfMonthEvent(
                  context.read<MonthSelectorCubit>().state.month,
                  context.read<MonthSelectorCubit>().state.year));
            }
          },
          child: BlocListener<MonthSelectorCubit, MonthSelectorState>(
            listener: (context, state) {
              context
                  .read<TransactionsBloc>()
                  .add(GetTransactionsOfMonthEvent(state.month, state.year));
            },
            child: BlocBuilder<TransactionsBloc, TransactionsState>(
              bloc: context.read<TransactionsBloc>()
                ..add(GetTransactionsOfMonthEvent(
                    context.read<MonthSelectorCubit>().state.month,
                    context.read<MonthSelectorCubit>().state.year)),
              builder: (context, state) {
                if (state is TransactionsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else if (state is TransactionsLoaded) {
                  return ListView.builder(
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) {
                      return TransactionListItem(
                        transaction: state.transactions[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Error'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
