/// Represents a validated ISO language code.
class LanguageCode {
  /// Creates a [LanguageCode] after basic validation.
  factory LanguageCode(String code) {
    if (code.isEmpty || code.length > 8) {
      throw ArgumentError('Invalid language code');
    }
    return LanguageCode._(code);
  }

  /// The underlying string value of the language code.
  const LanguageCode._(this.value);

  /// The language code value.
  final String value;
}
