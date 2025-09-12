import 'package:core_foundation/core/core.dart';
import '../../domain/entities/user.dart' as domain;
import '../../domain/repositories/user_repository.dart';

class InMemoryUserRepository implements UserRepository {
  domain.User? _cached;
  final PerformanceMonitor _monitor;

  InMemoryUserRepository(this._monitor);

  @override
  Future<Result<domain.User>> loadUser() async {
    try {
      return await _monitor.track<Result<domain.User>>('UserRepository.loadUser', () async {
        await Future<void>.delayed(const Duration(milliseconds: 800));
        _cached = _cached ?? const domain.User(
          id: '1',
          name: 'John Doe',
          email: 'john.doe@example.com',
        );
        return Success(_cached!);
      });
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> clearUser() async {
    try {
      return await _monitor.track<Result<void>>('UserRepository.clearUser', () async {
        _cached = null;
        return const Success(null);
      });
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
