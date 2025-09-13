import 'package:flutter/foundation.dart';

/// Simple user entity representing a signed-in user.
@immutable
class User {
  /// Creates a [User] with [id], [name], and [email].
  const User({required this.id, required this.name, required this.email});

  /// The user ID.
  final String id;

  /// The user's name.
  final String name;

  /// The user's email address.
  final String email;

  /// Returns a string representation of the user.
  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';

  /// Checks equality with another object.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email;
  }

  /// Returns the hash code for the user.
  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}
