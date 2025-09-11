import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_flutter_demo/core/errors/failures.dart';
import 'package:mvvm_flutter_demo/core/result/result.dart';
import 'package:mvvm_flutter_demo/features/home/application/usecases/clear_user.dart';
import 'package:mvvm_flutter_demo/features/home/application/usecases/load_user.dart';
import 'package:mvvm_flutter_demo/features/home/domain/entities/user.dart' as domain;
import 'package:mvvm_flutter_demo/features/home/domain/repositories/user_repository.dart';
import 'package:mvvm_flutter_demo/features/home/presentation/viewmodels/home_viewmodel.dart';

class _FakeUserRepository implements UserRepository {
  Result<domain.User> loadResult;
  Result<void> clearResult;

  _FakeUserRepository({required this.loadResult, required this.clearResult});

  @override
  Future<Result<domain.User>> loadUser() async => loadResult;

  @override
  Future<Result<void>> clearUser() async => clearResult;
}

void main() {
  group('HomeViewModel', () {
    test('loadUser success updates state', () async {
      final user = domain.User(id: '42', name: 'Ada', email: 'ada@example.com');
      final repo = _FakeUserRepository(loadResult: Success(user), clearResult: const Success(null));
      final vm = HomeViewModel(
        loadUser: LoadUser(repo),
        clearUser: ClearUser(repo),
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
      final vm = HomeViewModel(
        loadUser: LoadUser(repo),
        clearUser: ClearUser(repo),
      );

      await vm.loadUser();

      expect(vm.currentUser, isNull);
      expect(vm.errorMessage, isNotNull);
      expect(vm.isLoading, isFalse);
    });

    test('clearUser resets state', () async {
      final user = domain.User(id: '42', name: 'Ada', email: 'ada@example.com');
      final repo = _FakeUserRepository(loadResult: Success(user), clearResult: const Success(null));
      final vm = HomeViewModel(
        loadUser: LoadUser(repo),
        clearUser: ClearUser(repo),
      );

      await vm.loadUser();
      await vm.clearUser();

      expect(vm.currentUser, isNull);
      expect(vm.buttonClickCount, 0);
      expect(vm.errorMessage, isNull);
    });
  });
}
