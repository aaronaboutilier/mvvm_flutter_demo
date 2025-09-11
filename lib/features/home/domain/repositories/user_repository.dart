import '../../../../core/result/result.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Result<User>> loadUser();
  Future<Result<void>> clearUser();
}
