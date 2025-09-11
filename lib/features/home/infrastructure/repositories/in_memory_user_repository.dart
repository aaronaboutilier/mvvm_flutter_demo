import '../../../../core/core.dart';
import '../../domain/entities/user.dart' as domain;
import '../../domain/repositories/user_repository.dart';

class InMemoryUserRepository implements UserRepository {
  domain.User? _cached;

  @override
  Future<Result<domain.User>> loadUser() async {
    try {
      // Simulate a network call delay
      await Future.delayed(const Duration(milliseconds: 800));
      _cached = _cached ?? const domain.User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
      );
      return Success(_cached!);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> clearUser() async {
    _cached = null;
    return const Success(null);
  }
}
