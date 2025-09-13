import 'package:core_foundation/core/core.dart';
import 'package:feature_dashboard/src/domain/entities/user.dart' as domain;
import 'package:feature_dashboard/src/domain/repositories/user_repository.dart';

/// In-memory implementation of [UserRepository].
class InMemoryUserRepository implements UserRepository {
  /// Creates an [InMemoryUserRepository] with a [PerformanceMonitor].
  InMemoryUserRepository(this._monitor);

  /// Cached user instance.
  domain.User? _cached;

  /// Performance monitor for tracking operations.
  final PerformanceMonitor _monitor;

  /// Loads the user from memory or creates a default user.
  @override
  Future<Result<domain.User>> loadUser() async {
    return resultGuard<domain.User>(() async {
      return _monitor.track<domain.User>('UserRepository.loadUser', () async {
        await Future<void>.delayed(const Duration(milliseconds: 800));
        _cached =
            _cached ??
            const domain.User(
              id: '1',
              name: 'John Doe',
              email: 'john.doe@example.com',
            );
        return _cached!;
      });
    });
  }

  /// Clears the cached user.
  @override
  Future<Result<void>> clearUser() async {
    return resultGuard<void>(() async {
      return _monitor.track<void>('UserRepository.clearUser', () async {
        _cached = null;
      });
    });
  }
}
