/// Use case for adding a detail item.
library;

import 'package:core_foundation/core/core.dart';
import 'package:feature_details/src/domain/repositories/details_repository.dart';

/// Adds a detail item using the provided [DetailsRepository].
class AddDetailItem {
  /// Creates an [AddDetailItem] use case with the given [repo].
  AddDetailItem(this.repo);

  /// The repository used to add detail items.
  final DetailsRepository repo;

  /// Adds a detail item with the given [params].
  Future<Result<void>> call(String params) async {
    try {
      return await repo.addItem(params);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
