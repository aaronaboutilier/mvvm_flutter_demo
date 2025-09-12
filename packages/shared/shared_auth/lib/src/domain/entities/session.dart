class Session {
  final String userId;
  final String token;
  final DateTime expiresAt;

  Session({required this.userId, required this.token, required this.expiresAt});

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
