import 'failure.dart';

/// Network-related failure (timeouts, connectivity, status codes).
class NetworkFailure extends Failure {
  final int? statusCode;
  const NetworkFailure({
    required super.message,
    this.statusCode,
    String? code,
    super.cause,
    super.stackTrace,
  }) : super(code: code ?? 'network');
}

/// Validation/business rule violation failure.
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;
  const ValidationFailure({
    required super.message,
    this.fieldErrors,
    String? code,
    super.cause,
    super.stackTrace,
  }) : super(code: code ?? 'validation');
}

/// Configuration-related failure (missing keys, invalid formats).
class ConfigFailure extends Failure {
  const ConfigFailure({
    required super.message,
    String? code,
    super.cause,
    super.stackTrace,
  }) : super(code: code ?? 'config');
}

/// Missing resource failure.
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    String? code,
    super.cause,
    super.stackTrace,
  }) : super(code: code ?? 'not_found');
}

/// Unknown/unclassified failure type to avoid exposing raw exceptions.
class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    String? code,
    super.cause,
    super.stackTrace,
  }) : super(code: code ?? 'unknown');
}
