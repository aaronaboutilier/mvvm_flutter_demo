import '../../../../core/errors/failures.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/detail_item.dart';
import '../../domain/repositories/details_repository.dart';

class InMemoryDetailsRepository implements DetailsRepository {
  final List<DetailItem> _items = <DetailItem>[];

  @override
  Future<Result<List<DetailItem>>> getItems() async {
    return Success(List.unmodifiable(_items));
  }

  @override
  Future<Result<void>> addItem(String name) async {
    if (name.trim().isEmpty) {
      return const FailureResult<void>(ValidationFailure(message: 'Name cannot be empty'));
    }
    final ts = DateTime.now().millisecondsSinceEpoch;
    _items.add(DetailItem(name: name, timestampMillis: ts));
    return const Success(null);
  }

  @override
  Future<Result<void>> removeAt(int index) async {
    if (index < 0 || index >= _items.length) {
      return const FailureResult<void>(NotFoundFailure(message: 'Index out of range'));
    }
    _items.removeAt(index);
    return const Success(null);
  }

  @override
  Future<Result<void>> clearAll() async {
    _items.clear();
    return const Success(null);
  }

  @override
  Future<Result<void>> reorder({required int oldIndex, required int newIndex}) async {
    var n = newIndex;
    if (oldIndex < n) n -= 1;
    if (oldIndex < 0 || oldIndex >= _items.length || n < 0 || n >= _items.length) {
      return const FailureResult<void>(ValidationFailure(message: 'Invalid indices'));
    }
    final item = _items.removeAt(oldIndex);
    _items.insert(n, item);
    return const Success(null);
  }
}
