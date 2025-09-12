import 'package:core_foundation/core/core.dart';
import '../../domain/repositories/user_repository.dart';

class ClearUser implements UseCase<void, NoParams> {
  final UserRepository repo;
  ClearUser(this.repo);

  @override
  Future<Result<void>> call(NoParams params) async {
    try {
      return await repo.clearUser();
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
