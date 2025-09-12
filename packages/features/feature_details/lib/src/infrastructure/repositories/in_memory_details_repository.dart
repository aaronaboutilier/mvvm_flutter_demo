import 'package:core_foundation/core/core.dart';
import '../../domain/entities/detail_item.dart';
import '../../domain/repositories/details_repository.dart';

class InMemoryDetailsRepository implements DetailsRepository {
  final List<DetailItem> _items = <DetailItem>[];
  final PerformanceMonitor _monitor;

  InMemoryDetailsRepository(this._monitor);

  @override
  Future<Result<List<DetailItem>>> getItems() async {
    return _monitor.track<Result<List<DetailItem>>>(
      'DetailsRepository.getItems',
      () async => Success(List.unmodifiable(_items)),
    );
  }

  @override
  Future<Result<void>> addItem(String name) async {
    return _monitor.track<Result<void>>(
      'DetailsRepository.addItem',
      () async {
        if (name.trim().isEmpty) {
          return FailureResult<void>(Failure(message: 'Name cannot be empty', code: 'validation'));
        }
        final ts = DateTime.now().millisecondsSinceEpoch;
        _items.add(DetailItem(name: name, timestampMillis: ts));
        return const Success(null);
      },
    );
  }

  @override
  Future<Result<void>> removeAt(int index) async {
    return _monitor.track<Result<void>>(
      'DetailsRepository.removeAt',
      () async {
        if (index < 0 || index >= _items.length) {
          return FailureResult<void>(Failure(message: 'Index out of range', code: 'not_found'));
        }
        _items.removeAt(index);
        return const Success(null);
      },
    );
  }

  @override
  Future<Result<void>> clearAll() async {
    return _monitor.track<Result<void>>(
      'DetailsRepository.clearAll',
      () async {
        _items.clear();
        return const Success(null);
      },
    );
  }

  @override
  Future<Result<void>> reorder({required int oldIndex, required int newIndex}) async {
    return _monitor.track<Result<void>>(
      'DetailsRepository.reorder',
      () async {
        var n = newIndex;
        if (oldIndex < n) n -= 1;
        if (oldIndex < 0 || oldIndex >= _items.length || n < 0 || n >= _items.length) {
          return FailureResult<void>(Failure(message: 'Invalid indices', code: 'validation'));
        }
        final item = _items.removeAt(oldIndex);
        _items.insert(n, item);
        return const Success(null);
      },
    );
  }
}
