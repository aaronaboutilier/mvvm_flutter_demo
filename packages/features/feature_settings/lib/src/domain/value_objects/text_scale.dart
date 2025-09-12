class TextScale {
  final double value;
  const TextScale._(this.value);

  factory TextScale(double v) {
    if (v < 0.5 || v > 3.0) {
      throw ArgumentError('TextScale must be between 0.5 and 3.0');
    }
    return TextScale._(v);
  }
}
