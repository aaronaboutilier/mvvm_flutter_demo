import 'package:core_foundation/core/core.dart';
import 'package:feature_dashboard/src/domain/repositories/user_repository.dart';

/// Use case for clearing the current user.
class ClearUser {
  /// Creates a [ClearUser] use case.
  ClearUser(this.repo);

  /// The user repository.
  final UserRepository repo;

  /// Executes the use case to clear the user.
  Future<Result<void>> call(NoParams params) async {
    // Repository already wraps exceptions via resultGuard; just return.
    return repo.clearUser();
  }
}
