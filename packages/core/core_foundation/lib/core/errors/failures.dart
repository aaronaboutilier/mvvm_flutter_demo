import 'package:core_foundation/core/errors/failure.dart';

/// Unknown/unclassified failure type to avoid exposing raw exceptions.
class UnknownFailure extends Failure {
  /// Creates an [UnknownFailure].
  const UnknownFailure({required super.message, super.cause, super.stackTrace})
    : super(code: 'unknown');
}

/// Network-related failure (timeouts, connectivity, status codes).
class NetworkFailure extends Failure {
  /// Creates a [NetworkFailure].
  const NetworkFailure({
    required super.message,
    this.statusCode,
    super.cause,
    super.stackTrace,
  }) : super(code: 'network');

  /// Optional HTTP status code.
  final int? statusCode;
}

/// Validation/business rule violation failure.
class ValidationFailure extends Failure {
  /// Creates a [ValidationFailure].
  const ValidationFailure({
    required super.message,
    this.fieldErrors,
    super.cause,
    super.stackTrace,
  }) : super(code: 'validation');

  /// Optional field errors.
  final Map<String, String>? fieldErrors;
}

/// Configuration-related failure (missing keys, invalid formats).
class ConfigFailure extends Failure {
  /// Creates a [ConfigFailure].
  const ConfigFailure({required super.message, super.cause, super.stackTrace})
    : super(code: 'config');
}

/// Missing resource failure.
class NotFoundFailure extends Failure {
  /// Creates a [NotFoundFailure].
  const NotFoundFailure({required super.message, super.cause, super.stackTrace})
    : super(code: 'not_found');
}
