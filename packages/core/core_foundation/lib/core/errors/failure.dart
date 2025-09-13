/// Base domain failure carrying a message and optional details.
class Failure implements Exception {
  /// Creates a [Failure].
  const Failure({
    required this.message,
    this.code,
    this.cause,
    this.stackTrace,
  });

  /// Failure message.
  final String message;

  /// Optional failure code.
  final String? code;

  /// Optional cause of the failure.
  final Object? cause;

  /// Optional stack trace for the failure.
  final StackTrace? stackTrace;

  /// Returns a string representation of the failure.
  @override
  String toString() => 'Failure(code: ${code ?? 'unknown'}, message: $message)';
}
