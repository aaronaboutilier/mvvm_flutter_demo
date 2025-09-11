import '../../../../core/core.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class LoadUser implements UseCase<User, NoParams> {
  final UserRepository repo;
  LoadUser(this.repo);

  @override
  Future<Result<User>> call(NoParams params) async {
    try {
      return await repo.loadUser();
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
