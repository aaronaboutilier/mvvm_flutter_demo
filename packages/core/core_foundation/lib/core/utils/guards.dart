/// Lightweight guard helpers for validating inputs in value objects/use cases.
class Guards {
  /// Private constructor to prevent instantiation.
  const Guards._();

  /// Ensures [value] is not empty, throws [ArgumentError] if it is.
  static String nonEmpty(String value, {String fieldName = 'value'}) {
    if (value.trim().isEmpty) {
      throw ArgumentError('$fieldName must not be empty');
    }
    return value;
  }

  /// Ensures [value] is not null, throws [ArgumentError] if it is.
  static T notNull<T>(T? value, {String fieldName = 'value'}) {
    if (value == null) {
      throw ArgumentError('$fieldName must not be null');
    }
    return value;
  }
}
