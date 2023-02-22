import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'cubit/month_selector_cubit.dart';

class MonthSelectorDialog extends StatelessWidget {
  MonthSelectorDialog({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Select Month & Year',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: IntrinsicHeight(
        child: FormBuilder(
          key: _formKey,
          child: BlocBuilder<MonthSelectorCubit, MonthSelectorState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: FormBuilderDropdown(
                      name: 'month',
                      initialValue: state.month,
                      items: [
                        for (var i = 1; i <= 12; i++)
                          DropdownMenuItem(
                            value: i,
                            child: Text(
                              DateFormat('MMM').format(
                                DateTime(state.year, i),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: FormBuilderDropdown(
                      name: 'year',
                      initialValue: state.year,
                      items: [
                        for (var i = DateTime.now().year - 12;
                            i <= DateTime.now().year;
                            i++)
                          DropdownMenuItem(
                            value: i,
                            child: Text(i.toString()),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              context.read<MonthSelectorCubit>().changeMonthYear(
                    _formKey.currentState!.value['month'],
                    _formKey.currentState!.value['year'],
                  );
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            'Select',
          ),
        ),
      ],
    );
  }
}