import 'package:core_foundation/core/core.dart';
import '../../domain/repositories/details_repository.dart';

class RemoveDetailItem implements UseCase<void, int> {
  final DetailsRepository repo;
  RemoveDetailItem(this.repo);

  @override
  Future<Result<void>> call(int index) async {
    try {
      return await repo.removeAt(index);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
