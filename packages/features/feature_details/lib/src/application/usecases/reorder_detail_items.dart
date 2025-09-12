import 'package:core_foundation/core/core.dart';
import '../../domain/repositories/details_repository.dart';

class ReorderParams {
  final int oldIndex;
  final int newIndex;
  const ReorderParams({required this.oldIndex, required this.newIndex});
}

class ReorderDetailItems implements UseCase<void, ReorderParams> {
  final DetailsRepository repo;
  ReorderDetailItems(this.repo);

  @override
  Future<Result<void>> call(ReorderParams params) async {
    try {
      return await repo.reorder(oldIndex: params.oldIndex, newIndex: params.newIndex);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
