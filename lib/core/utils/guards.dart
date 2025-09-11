/// Lightweight guard helpers for validating inputs in value objects/use cases.
class Guards {
  const Guards._();

  static String nonEmpty(String value, {String fieldName = 'value'}) {
    if (value.trim().isEmpty) {
      throw ArgumentError('$fieldName must not be empty');
    }
    return value;
  }

  static T notNull<T>(T? value, {String fieldName = 'value'}) {
    if (value == null) {
      throw ArgumentError('$fieldName must not be null');
    }
    return value;
  }
}
