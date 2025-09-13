import 'package:core_foundation/core/core.dart';
import 'package:feature_dashboard/src/domain/entities/user.dart';

/// Contract for loading and clearing the current user.
abstract class UserRepository {
  /// Loads the current user if available.
  Future<Result<User>> loadUser();

  /// Clears any cached user information.
  Future<Result<void>> clearUser();
}
