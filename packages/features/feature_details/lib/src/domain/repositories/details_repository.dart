import 'package:core_foundation/core/core.dart';
import 'package:feature_details/src/domain/entities/detail_item.dart';

/// Repository interface for managing detail items.
abstract class DetailsRepository {
  /// Retrieves the list of detail items.
  Future<Result<List<DetailItem>>> getItems();

  /// Adds a new detail item with the given [name].
  Future<Result<void>> addItem(String name);

  /// Removes the detail item at the specified [index].
  Future<Result<void>> removeAt(int index);

  /// Clears all detail items.
  Future<Result<void>> clearAll();

  /// Reorders detail items from [oldIndex] to [newIndex].
  Future<Result<void>> reorder({required int oldIndex, required int newIndex});
}
