import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/authentication_repo.dart';

class Logout implements UseCase<void, NoParams> {
  final AuthenticationRepo repository;

  Logout(this.repository);

  @override
  Future<Either<Exception, bool>> call(NoParams params) async {
    return await repository.logout();
  }
}