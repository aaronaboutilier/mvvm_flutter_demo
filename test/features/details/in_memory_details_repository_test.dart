import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_flutter_demo/core/result/result.dart';
import 'package:mvvm_flutter_demo/features/details/domain/entities/detail_item.dart';
import 'package:mvvm_flutter_demo/features/details/infrastructure/repositories/in_memory_details_repository.dart';
import 'package:mvvm_flutter_demo/core/core.dart';

void main() {
  group('InMemoryDetailsRepository', () {
    test('addItem adds non-empty items and getItems returns them', () async {
  final repo = InMemoryDetailsRepository(PerformanceMonitor(const DebugLogger()));
      expect((await repo.getItems()), isA<Success<List<DetailItem>>>());
      await repo.addItem('A');
      final res = await repo.getItems();
      expect(res, isA<Success<List<DetailItem>>>());
      final items = (res as Success<List<DetailItem>>).value;
      expect(items.length, 1);
      expect(items.first.name, 'A');
    });

    test('addItem rejects empty names', () async {
  final repo = InMemoryDetailsRepository(PerformanceMonitor(const DebugLogger()));
      final res = await repo.addItem('   ');
      expect(res, isA<FailureResult<void>>());
    });

    test('removeAt validates bounds', () async {
  final repo = InMemoryDetailsRepository(PerformanceMonitor(const DebugLogger()));
      expect(await repo.removeAt(0), isA<FailureResult<void>>());
      await repo.addItem('A');
      expect(await repo.removeAt(1), isA<FailureResult<void>>());
      expect(await repo.removeAt(0), isA<Success<void>>());
    });

    test('reorder validates indices and reorders properly', () async {
  final repo = InMemoryDetailsRepository(PerformanceMonitor(const DebugLogger()));
      await repo.addItem('A');
      await repo.addItem('B');
      await repo.addItem('C');
      // invalid indexes
      expect(await repo.reorder(oldIndex: -1, newIndex: 1), isA<FailureResult<void>>());
      expect(await repo.reorder(oldIndex: 0, newIndex: 5), isA<FailureResult<void>>());
      // valid reorder
      final before = (await repo.getItems() as Success<List<DetailItem>>).value;
      expect(before.map((e) => e.name).toList(), ['A', 'B', 'C']);
      await repo.reorder(oldIndex: 0, newIndex: 2);
      final after = (await repo.getItems() as Success<List<DetailItem>>).value;
      expect(after.map((e) => e.name).toList(), ['B', 'A', 'C']);
    });

    test('clearAll empties the list', () async {
      final repo = InMemoryDetailsRepository(PerformanceMonitor(const DebugLogger()));
      await repo.addItem('A');
      await repo.clearAll();
      final res = await repo.getItems();
      expect((res as Success<List<DetailItem>>).value, isEmpty);
    });
  });
}
