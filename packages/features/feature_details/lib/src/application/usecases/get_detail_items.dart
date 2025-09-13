/// Use case for retrieving all detail items.
library;

import 'package:core_foundation/core/core.dart';
import 'package:feature_details/src/domain/entities/detail_item.dart';
import 'package:feature_details/src/domain/repositories/details_repository.dart';

/// Retrieves all detail items using the provided [DetailsRepository].
class GetDetailItems {
  /// Creates a [GetDetailItems] use case with the given [repo].
  GetDetailItems(this.repo);

  /// The repository used to get detail items.
  final DetailsRepository repo;

  /// Retrieves all detail items.
  Future<Result<List<DetailItem>>> call(NoParams params) async {
    try {
      return await repo.getItems();
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
