import 'package:flutter_test/flutter_test.dart';
import 'package:core_foundation/core/core.dart' as foundation;
import 'package:feature_details/feature_details.dart';

class _FakeDetailsRepo implements DetailsRepository {
  final List<DetailItem> _items = [];

  @override
  Future<foundation.Result<void>> addItem(String name) async {
    _items.add(DetailItem(name: name, timestampMillis: DateTime(2024, 1, 1).millisecondsSinceEpoch));
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> clearAll() async {
    _items.clear();
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<List<DetailItem>>> getItems() async => foundation.Success(List.unmodifiable(_items));

  @override
  Future<foundation.Result<void>> removeAt(int index) async {
    _items.removeAt(index);
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> reorder({required int oldIndex, required int newIndex}) async {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);
    return const foundation.Success(null);
  }
}

void main() {
  group('DetailsViewModel', () {
    test('add and list items', () async {
      final repo = _FakeDetailsRepo();
      final vm = DetailsViewModel(
        getItems: GetDetailItems(repo),
        addItem: AddDetailItem(repo),
        removeItem: RemoveDetailItem(repo),
        clearItems: ClearDetailItems(repo),
        reorderItems: ReorderDetailItems(repo),
      );

      expect(vm.itemCount, 0);
      await vm.addItem('Alpha');
      await vm.addItem('Beta');

      expect(vm.itemCount, 2);
      expect(vm.items.first.contains('Alpha'), isTrue);
    });

    test('remove and clear items', () async {
      final repo = _FakeDetailsRepo();
      final vm = DetailsViewModel(
        getItems: GetDetailItems(repo),
        addItem: AddDetailItem(repo),
        removeItem: RemoveDetailItem(repo),
        clearItems: ClearDetailItems(repo),
        reorderItems: ReorderDetailItems(repo),
      );

      await vm.addItem('A');
      await vm.addItem('B');
      expect(vm.itemCount, 2);

      await vm.removeItem(0);
      expect(vm.itemCount, 1);

      await vm.clearAllItems();
      expect(vm.itemCount, 0);
    });

    test('reorder items', () async {
      final repo = _FakeDetailsRepo();
      final vm = DetailsViewModel(
        getItems: GetDetailItems(repo),
        addItem: AddDetailItem(repo),
        removeItem: RemoveDetailItem(repo),
        clearItems: ClearDetailItems(repo),
        reorderItems: ReorderDetailItems(repo),
      );

      await vm.addItem('A');
      await vm.addItem('B');
      await vm.addItem('C');
      expect(vm.items[0].contains('A'), isTrue);

      vm.reorderItems(0, 2);
      await Future<void>.delayed(const Duration(milliseconds: 1));
      expect(vm.items[1].contains('A'), isTrue);
    });
  });
}
