import 'package:shared_user/src/domain/entities/user.dart';

/// Repository interface for user operations.
abstract class UserRepository {
  /// Gets the current user if available.
  Future<UserEntity?> getCurrentUser();

  /// Gets a user by their [id].
  Future<UserEntity> getUserById(String id);
}
