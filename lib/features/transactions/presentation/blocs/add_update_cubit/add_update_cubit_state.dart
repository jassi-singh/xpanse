part of 'add_update_cubit.dart';

enum AddUpdateStatus { initial, loading, success, failure }

class AddUpdateState extends Equatable {
  final AddUpdateStatus status;
  final String? error;
  const AddUpdateState(this.status, {this.error});

  @override
  List<Object> get props => [status];
}
