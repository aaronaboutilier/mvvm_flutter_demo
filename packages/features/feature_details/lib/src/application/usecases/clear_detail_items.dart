import 'package:core_foundation/core/core.dart';
import 'package:feature_details/src/domain/repositories/details_repository.dart';

/// Clears all detail items using the provided [DetailsRepository].
class ClearDetailItems {
  /// Creates a [ClearDetailItems] use case with the given [repo].
  ClearDetailItems(this.repo);

  /// The repository used to clear detail items.
  final DetailsRepository repo;

  /// Clears all detail items.
  Future<Result<void>> call(NoParams params) async {
    try {
      return await repo.clearAll();
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
