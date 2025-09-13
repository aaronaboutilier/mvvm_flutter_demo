/// Use case for removing a detail item by index.
library;

import 'package:core_foundation/core/core.dart';
import 'package:feature_details/src/domain/repositories/details_repository.dart';

/// Removes a detail item at the specified index using the provided
/// [DetailsRepository].
class RemoveDetailItem {
  /// Creates a [RemoveDetailItem] use case with the given [repo].
  RemoveDetailItem(this.repo);

  /// The repository used to remove detail items.
  final DetailsRepository repo;

  /// Removes a detail item at the given [index].
  Future<Result<void>> call(int index) async {
    try {
      return await repo.removeAt(index);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
