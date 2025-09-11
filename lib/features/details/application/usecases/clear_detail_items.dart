import '../../../../core/core.dart';
import '../../domain/repositories/details_repository.dart';

class ClearDetailItems implements UseCase<void, NoParams> {
  final DetailsRepository repo;
  ClearDetailItems(this.repo);

  @override
  Future<Result<void>> call(NoParams params) async {
    try {
      return await repo.clearAll();
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
