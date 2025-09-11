class ValidationException implements Exception {
  final String message;
  const ValidationException(this.message);
  @override
  String toString() => 'ValidationException: $message';
}

class Email {
  final String value;
  Email._(this.value);

  factory Email.create(String input) {
    final sanitized = input.trim().toLowerCase();
    if (sanitized.isEmpty) throw const ValidationException('Email cannot be empty');
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(sanitized)) throw const ValidationException('Invalid email format');
    return Email._(sanitized);
  }

  @override
  String toString() => value;
}
