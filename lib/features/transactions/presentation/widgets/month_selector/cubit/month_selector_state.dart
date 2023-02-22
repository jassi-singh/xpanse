part of 'month_selector_cubit.dart';

abstract class MonthSelectorState extends Equatable {
  final int month;
  final int year;
  const MonthSelectorState(this.month, this.year);

  @override
  List<Object> get props => [month, year];
}

class MonthSelectorInitial extends MonthSelectorState {
  const MonthSelectorInitial(int month, int year) : super(month, year);
}
