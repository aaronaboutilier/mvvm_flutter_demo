import 'package:shared_auth/src/domain/entities/session.dart';

/// Repository interface for authentication operations.
abstract class AuthRepository {
  /// Gets the current session if available.
  Future<Session?> getCurrentSession();

  /// Signs in with [username] and [password], returning a [Session].
  Future<Session> signIn({required String username, required String password});

  /// Signs out the current session.
  Future<void> signOut();
}
