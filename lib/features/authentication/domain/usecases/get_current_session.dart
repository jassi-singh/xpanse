import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/authentication_repo.dart';

class GetCurrentSession extends UseCase<Session, NoParams> {
  final AuthenticationRepo _repository;

  GetCurrentSession(this._repository);

  @override
  Future<Either<Exception, Session>> call(NoParams params) async {
    return await _repository.getCurrentSession();
  }
}
