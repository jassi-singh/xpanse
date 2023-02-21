part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  final int index;

  const HomeState(
    this.index,
  );
  @override
  List<Object> get props => [index];
}

class HomeInitial extends HomeState {
  const HomeInitial(int index) : super(index);
}
