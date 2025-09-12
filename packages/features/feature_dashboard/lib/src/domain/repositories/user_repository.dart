import 'package:core_foundation/core/core.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Result<User>> loadUser();
  Future<Result<void>> clearUser();
}
