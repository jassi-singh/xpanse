import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/app_button.dart';
import 'cubit/month_selector_cubit.dart';
import 'month_selector_dialog.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppButton(
          onPressed: () => context.read<MonthSelectorCubit>().previousMonth(),
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        AppButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => MonthSelectorDialog(),
            );
          },
          backgroundColor: Colors.grey[800],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
              ),
              const SizedBox(width: 10),
              BlocSelector<MonthSelectorCubit, MonthSelectorState, String>(
                selector: (state) => DateFormat('MMM, yyyy')
                    .format(DateTime(state.year, state.month)),
                builder: (context, _dateTimeString) {
                  return Text(
                    _dateTimeString,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        AppButton(
          onPressed: () => context.read<MonthSelectorCubit>().nextMonth(),
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
