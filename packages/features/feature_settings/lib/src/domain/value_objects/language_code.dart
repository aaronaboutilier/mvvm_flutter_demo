class LanguageCode {
  final String value;
  const LanguageCode._(this.value);

  factory LanguageCode(String code) {
    if (code.isEmpty || code.length > 8) {
      throw ArgumentError('Invalid language code');
    }
    return LanguageCode._(code);
  }
}
