import 'entities/user.dart';

abstract class UserRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> getUserById(String id);
}
