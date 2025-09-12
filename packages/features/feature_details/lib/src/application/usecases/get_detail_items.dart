import 'package:core_foundation/core/core.dart';
import '../../domain/entities/detail_item.dart';
import '../../domain/repositories/details_repository.dart';

class GetDetailItems implements UseCase<List<DetailItem>, NoParams> {
  final DetailsRepository repo;
  GetDetailItems(this.repo);

  @override
  Future<Result<List<DetailItem>>> call(NoParams params) async {
    try {
      return await repo.getItems();
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
