import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'month_selector_state.dart';

class MonthSelectorCubit extends Cubit<MonthSelectorState> {
  MonthSelectorCubit()
      : super(MonthSelectorInitial(DateTime.now().month, DateTime.now().year));

  void changeMonthYear(int month,int year) {
    emit(MonthSelectorInitial(month, year));
  }

  void nextMonth() {
    final newDate = DateTime(state.year, state.month + 1);
    emit(MonthSelectorInitial(newDate.month, newDate.year));
  }

  void previousMonth() {
    final newDate = DateTime(state.year, state.month - 1);
    emit(MonthSelectorInitial(newDate.month, newDate.year));
  }
}
