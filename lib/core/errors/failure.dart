/// Base failure type for domain/application errors.
///
/// Keep this minimal in Phase 1; specific failure categories
/// (e.g., NetworkFailure, ValidationFailure) will be added in Phase 1, task 3.
abstract class Failure {
  /// Human-readable message safe for logging; UI mapping happens in ViewModels.
  final String message;

  /// Optional machine-readable code/category for analytics or conditional handling.
  final String? code;

  /// Underlying cause (exception/error) if available.
  final Object? cause;

  /// Stack trace captured at the origin of the failure if available.
  final StackTrace? stackTrace;

  const Failure({
    required this.message,
    this.code,
    this.cause,
    this.stackTrace,
  });

  @override
  String toString() => 'Failure(code: ${code ?? 'n/a'}, message: $message)';
}
