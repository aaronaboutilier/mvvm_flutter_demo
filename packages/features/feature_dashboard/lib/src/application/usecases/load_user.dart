import 'package:core_foundation/core/core.dart';
import 'package:feature_dashboard/src/domain/entities/user.dart';
import 'package:feature_dashboard/src/domain/repositories/user_repository.dart';

/// Use case for loading the current user.
class LoadUser {
  /// Creates a [LoadUser] use case.
  LoadUser(this.repo);

  /// The user repository.
  final UserRepository repo;

  /// Executes the use case to load the user.
  Future<Result<User>> call(NoParams params) async {
    return repo.loadUser();
  }
}
