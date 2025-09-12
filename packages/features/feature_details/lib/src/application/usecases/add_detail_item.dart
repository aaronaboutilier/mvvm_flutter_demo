import 'package:core_foundation/core/core.dart';
import '../../domain/repositories/details_repository.dart';

class AddDetailItem implements UseCase<void, String> {
  final DetailsRepository repo;
  AddDetailItem(this.repo);

  @override
  Future<Result<void>> call(String params) async {
    try {
      return await repo.addItem(params);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
