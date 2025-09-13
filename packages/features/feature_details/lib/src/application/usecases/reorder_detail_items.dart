import 'package:core_foundation/core/core.dart' hide ErrorMapper;
import 'package:core_foundation/core/utils/error_mapper.dart' as errors;
import 'package:feature_details/src/domain/repositories/details_repository.dart';

/// Parameters for reordering detail items.
class ReorderParams {
  /// Creates a [ReorderParams] with the given [oldIndex] and [newIndex].
  const ReorderParams({required this.oldIndex, required this.newIndex});

  /// The original index of the item.
  final int oldIndex;

  /// The new index for the item.
  final int newIndex;
}

/// Reorders detail items using the provided [DetailsRepository].
class ReorderDetailItems {
  /// Creates a [ReorderDetailItems] use case with the given [repo].
  ReorderDetailItems(this.repo);

  /// The repository used to reorder detail items.
  final DetailsRepository repo;

  /// Reorders a detail item from [ReorderParams.oldIndex] to
  /// [ReorderParams.newIndex].
  Future<Result<void>> call(ReorderParams params) async {
    try {
      return await repo.reorder(
        oldIndex: params.oldIndex,
        newIndex: params.newIndex,
      );
    } catch (e, s) {
      return FailureResult(errors.ErrorMapper.map(e, s));
    }
  }
}
