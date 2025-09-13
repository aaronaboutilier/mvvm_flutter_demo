/// Represents a validated text scale factor.
class TextScale {
  /// Creates a [TextScale] after validating its range.
  factory TextScale(double v) {
    if (v < 0.5 || v > 3.0) {
      throw ArgumentError('TextScale must be between 0.5 and 3.0');
    }
    return TextScale._(v);
  }

  /// The underlying double value of the text scale factor.
  const TextScale._(this.value);

  /// The text scale factor value.
  final double value;
}
