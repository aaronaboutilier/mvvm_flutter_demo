import 'package:flutter_test/flutter_test.dart';
import 'package:core_foundation/core/core.dart';
import 'package:feature_dashboard/feature_dashboard.dart' as dashboard;

class _FakeUserRepository implements dashboard.UserRepository {
  Result<dashboard.User> loadResult;
  Result<void> clearResult;

  _FakeUserRepository({required this.loadResult, required this.clearResult});

  @override
  Future<Result<dashboard.User>> loadUser() async => loadResult;

  @override
  Future<Result<void>> clearUser() async => clearResult;
}

void main() {
  group('HomeViewModel', () {
    test('loadUser success updates state', () async {
      final user = dashboard.User(id: '42', name: 'Ada', email: 'ada@example.com');
      final repo = _FakeUserRepository(loadResult: Success(user), clearResult: const Success(null));
      final vm = dashboard.HomeViewModel(
        loadUser: dashboard.LoadUser(repo),
        clearUser: dashboard.ClearUser(repo),
      );

      await vm.loadUser();

      expect(vm.currentUser, isNotNull);
      expect(vm.currentUser!.name, 'Ada');
      expect(vm.errorMessage, isNull);
      expect(vm.isLoading, isFalse);
    });

    test('loadUser failure sets error and clears user', () async {
      final failure = UnknownFailure(message: 'network');
      final repo = _FakeUserRepository(loadResult: FailureResult(failure), clearResult: const Success(null));
      final vm = dashboard.HomeViewModel(
        loadUser: dashboard.LoadUser(repo),
        clearUser: dashboard.ClearUser(repo),
      );

      await vm.loadUser();

      expect(vm.currentUser, isNull);
      expect(vm.errorMessage, isNotNull);
      expect(vm.isLoading, isFalse);
    });

    test('clearUser resets state', () async {
      final user = dashboard.User(id: '42', name: 'Ada', email: 'ada@example.com');
      final repo = _FakeUserRepository(loadResult: Success(user), clearResult: const Success(null));
      final vm = dashboard.HomeViewModel(
        loadUser: dashboard.LoadUser(repo),
        clearUser: dashboard.ClearUser(repo),
      );

      await vm.loadUser();
      await vm.clearUser();

      expect(vm.currentUser, isNull);
      expect(vm.buttonClickCount, 0);
      expect(vm.errorMessage, isNull);
    });
  });
}
