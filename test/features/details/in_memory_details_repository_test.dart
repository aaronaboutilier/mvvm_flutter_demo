import 'package:core_foundation/core/core.dart' as foundation;
import 'package:feature_details/feature_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InMemoryDetailsRepository', () {
    test('addItem adds non-empty items and getItems returns them', () async {
      final repo = InMemoryDetailsRepository(
        const foundation.PerformanceMonitor(foundation.DebugLogger()),
      );
      expect(
        await repo.getItems(),
        isA<foundation.Success<List<DetailItem>>>(),
      );
      await repo.addItem('A');
      final res = await repo.getItems();
      expect(res, isA<foundation.Success<List<DetailItem>>>());
      final items = (res as foundation.Success<List<DetailItem>>).value;
      expect(items.length, 1);
      expect(items.first.name, 'A');
    });

    test('addItem rejects empty names', () async {
      final repo = InMemoryDetailsRepository(
        const foundation.PerformanceMonitor(foundation.DebugLogger()),
      );
      final res = await repo.addItem('   ');
      expect(res, isA<foundation.FailureResult<void>>());
    });

    test('removeAt validates bounds', () async {
      final repo = InMemoryDetailsRepository(
        const foundation.PerformanceMonitor(foundation.DebugLogger()),
      );
      expect(await repo.removeAt(0), isA<foundation.FailureResult<void>>());
      await repo.addItem('A');
      expect(await repo.removeAt(1), isA<foundation.FailureResult<void>>());
      expect(await repo.removeAt(0), isA<foundation.Success<void>>());
    });

    test('reorder validates indices and reorders properly', () async {
      final repo = InMemoryDetailsRepository(
        const foundation.PerformanceMonitor(foundation.DebugLogger()),
      );
      await repo.addItem('A');
      await repo.addItem('B');
      await repo.addItem('C');
      // invalid indexes
      expect(
        await repo.reorder(oldIndex: -1, newIndex: 1),
        isA<foundation.FailureResult<void>>(),
      );
      expect(
        await repo.reorder(oldIndex: 0, newIndex: 5),
        isA<foundation.FailureResult<void>>(),
      );
      // valid reorder
      final before =
          (await repo.getItems() as foundation.Success<List<DetailItem>>).value;
      expect(before.map((e) => e.name).toList(), ['A', 'B', 'C']);
      await repo.reorder(oldIndex: 0, newIndex: 2);
      final after =
          (await repo.getItems() as foundation.Success<List<DetailItem>>).value;
      expect(after.map((e) => e.name).toList(), ['B', 'A', 'C']);
    });

    test('clearAll empties the list', () async {
      final repo = InMemoryDetailsRepository(
        const foundation.PerformanceMonitor(foundation.DebugLogger()),
      );
      await repo.addItem('A');
      await repo.clearAll();
      final res = await repo.getItems();
      expect((res as foundation.Success<List<DetailItem>>).value, isEmpty);
    });
  });
}
