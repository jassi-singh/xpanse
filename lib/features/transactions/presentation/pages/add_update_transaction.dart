import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:xpense/core/constants/colors.dart';
import 'package:xpense/core/extensions/string_extensions.dart';
import 'package:xpense/core/widgets/app_button.dart';
import 'package:xpense/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:xpense/features/transactions/presentation/blocs/add_update_cubit/add_update_cubit.dart';

import '../../domain/entities/enums.dart';
import '../../domain/entities/transaction.dart';

class AddUpdateTransaction extends StatelessWidget {
  final Transaction? transaction;
  AddUpdateTransaction({
    Key? key,
    this.transaction,
  }) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((transaction == null ? 'Add' : 'Update') + ' Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          initialValue: transaction?.toJson() ??
              {
                'type': 'expense',
              },
          onChanged: () {
            _formKey.currentState?.save();
          },
          child: Column(
            children: [
              if (transaction != null)
                Opacity(
                  opacity: 0.6,
                  child: FormBuilderTextField(
                    name: '\$id',
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'ID',
                      prefixIcon: Icon(Icons.numbers),
                    ),
                  ),
                ),
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              FormBuilderTextField(
                name: 'amount',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.currency_rupee),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderDropdown(
                name: 'type',
                decoration: const InputDecoration(
                  labelText: 'Type',
                  prefixIcon: Icon(Icons.money_sharp),
                ),
                items: TransactionType.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.name,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(e.name.capitalize),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderDropdown(
                name: 'category',
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Icons.category),
                ),
                items: CategoryEnum.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.name,
                        child: Text(e.name.capitalize),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 40,
              ),
              AppButton(
                onPressed: () {
                  final curState = context.read<AuthenticationBloc>().state;
                  if (_formKey.currentState!.saveAndValidate() &&
                      curState is AuthorizedState) {
                    final value = _formKey.currentState!.value;
                    context.read<AddUpdateCubit>().addOrUpdate(
                          Transaction.fromJson({
                            ...value,
                            'userId': curState.session.userId,
                            'date': transaction?.date.toString() ??
                                DateTime.now().toString(),
                          }),
                        );
                  }
                },
                child: BlocConsumer<AddUpdateCubit, AddUpdateState>(
                  listener: (context, state) {
                    if (state.status == AddUpdateStatus.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error!),
                        ),
                      );
                    } else if (state.status == AddUpdateStatus.success) {
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.status == AddUpdateStatus.loading) {
                      return const CircularProgressIndicator();
                    }
                    return Text(transaction == null ? 'ADD' : 'UPDATE');
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (transaction != null)
                AppButton(
                  onPressed: () {
                    context.read<AddUpdateCubit>().delete(transaction!.id!);
                  },
                  gradient: AppColors.dangerGradient,
                  child: const Text('DELETE'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
