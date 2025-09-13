/// Represents a user entity.
class UserEntity {
  /// Creates a [UserEntity] with the given [id], [name], and [email].
  const UserEntity({required this.id, required this.name, required this.email});

  /// The user ID.
  final String id;

  /// The user's name.
  final String name;

  /// The user's email address.
  final String email;
}
