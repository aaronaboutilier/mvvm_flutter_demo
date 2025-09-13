/// Exception thrown when validation fails.
class ValidationException implements Exception {
  /// Creates a [ValidationException] with the provided [message].
  const ValidationException(this.message);

  /// Description of the validation error.
  final String message;

  /// String representation of the validation error.
  @override
  String toString() => 'ValidationException: $message';
}

/// Value object representing a validated email address.
class Email {
  Email._(this.value);

  /// Creates a validated [Email] from raw [input].
  ///
  /// Trims and lowercases the input, and validates format.
  /// Throws [ValidationException] if invalid.
  factory Email.create(String input) {
    final sanitized = input.trim().toLowerCase();
    if (sanitized.isEmpty) {
      throw const ValidationException('Email cannot be empty');
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(sanitized)) {
      throw const ValidationException('Invalid email format');
    }
    return Email._(sanitized);
  }

  /// The normalized email value.
  final String value;

  /// Returns the normalized email string.
  @override
  String toString() => value;
}
