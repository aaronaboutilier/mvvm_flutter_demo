import 'package:core_foundation/core/core.dart';
import 'package:feature_details/src/domain/entities/detail_item.dart';
import 'package:feature_details/src/domain/repositories/details_repository.dart';

/// In-memory implementation of [DetailsRepository] for testing and demos.
class InMemoryDetailsRepository implements DetailsRepository {
  /// Creates an [InMemoryDetailsRepository] with the given
  /// [PerformanceMonitor].
  InMemoryDetailsRepository(this._monitor);

  final List<DetailItem> _items = <DetailItem>[];
  final PerformanceMonitor _monitor;

  /// Retrieves the current list of detail items.
  @override
  Future<Result<List<DetailItem>>> getItems() async {
    return _monitor.track<Result<List<DetailItem>>>(
      'DetailsRepository.getItems',
      () async => Success(List.unmodifiable(_items)),
    );
  }

  /// Adds a new item with the provided [name].
  @override
  Future<Result<void>> addItem(String name) async {
    return _monitor.track<Result<void>>('DetailsRepository.addItem', () async {
      if (name.trim().isEmpty) {
        return const FailureResult<void>(
          Failure(message: 'Name cannot be empty', code: 'validation'),
        );
      }
      final ts = DateTime.now().millisecondsSinceEpoch;
      _items.add(DetailItem(name: name, timestampMillis: ts));
      return const Success(null);
    });
  }

  /// Removes the item at the specified [index].
  @override
  Future<Result<void>> removeAt(int index) async {
    return _monitor.track<Result<void>>('DetailsRepository.removeAt', () async {
      if (index < 0 || index >= _items.length) {
        return const FailureResult<void>(
          Failure(message: 'Index out of range', code: 'not_found'),
        );
      }
      _items.removeAt(index);
      return const Success(null);
    });
  }

  /// Clears all stored items.
  @override
  Future<Result<void>> clearAll() async {
    return _monitor.track<Result<void>>('DetailsRepository.clearAll', () async {
      _items.clear();
      return const Success(null);
    });
  }

  /// Reorders items from [oldIndex] to [newIndex].
  @override
  Future<Result<void>> reorder({
    required int oldIndex,
    required int newIndex,
  }) async {
    return _monitor.track<Result<void>>('DetailsRepository.reorder', () async {
      var n = newIndex;
      if (oldIndex < n) n -= 1;
      if (oldIndex < 0 ||
          oldIndex >= _items.length ||
          n < 0 ||
          n >= _items.length) {
        return const FailureResult<void>(
          Failure(message: 'Invalid indices', code: 'validation'),
        );
      }
      final item = _items.removeAt(oldIndex);
      _items.insert(n, item);
      return const Success(null);
    });
  }
}
