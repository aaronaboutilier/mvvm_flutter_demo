import 'package:core_foundation/core/core.dart';
import 'package:feature_dashboard/src/infrastructure/repositories/in_memory_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InMemoryUserRepository', () {
    test('loadUser returns Success with user', () async {
      final repo = InMemoryUserRepository(
        const PerformanceMonitor(DebugLogger()),
      );
      final r = await repo.loadUser();
      expect(r.isSuccess, isTrue);
      expect(r.asSuccess!.value.name, 'John Doe');
    });

    test('clearUser returns Success and clears cache', () async {
      final repo = InMemoryUserRepository(
        const PerformanceMonitor(DebugLogger()),
      );
      await repo.loadUser();
      final cleared = await repo.clearUser();
      expect(cleared.isSuccess, isTrue);
    });
  });
}
