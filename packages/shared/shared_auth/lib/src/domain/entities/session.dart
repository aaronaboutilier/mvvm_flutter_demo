/// Represents a user session.
class Session {
  /// Creates a [Session] with the given [userId], [token], and [expiresAt].
  Session({required this.userId, required this.token, required this.expiresAt});

  /// The user ID associated with the session.
  final String userId;

  /// The authentication token.
  final String token;

  /// The expiration date and time of the session.
  final DateTime expiresAt;

  /// Returns true if the session is expired.
  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
