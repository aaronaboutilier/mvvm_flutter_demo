import 'failure.dart';

/// Unknown/unclassified failure type to avoid exposing raw exceptions.
class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.cause, super.stackTrace})
      : super(code: 'unknown');
}

/// Network-related failure (timeouts, connectivity, status codes).
class NetworkFailure extends Failure {
  final int? statusCode;
  const NetworkFailure({
    required super.message,
    this.statusCode,
    super.cause,
    super.stackTrace,
  }) : super(code: 'network');
}

/// Validation/business rule violation failure.
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;
  const ValidationFailure({
    required super.message,
    this.fieldErrors,
    super.cause,
    super.stackTrace,
  }) : super(code: 'validation');
}

/// Configuration-related failure (missing keys, invalid formats).
class ConfigFailure extends Failure {
  const ConfigFailure({
    required super.message,
    super.cause,
    super.stackTrace,
  }) : super(code: 'config');
}

/// Missing resource failure.
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    super.cause,
    super.stackTrace,
  }) : super(code: 'not_found');
}
