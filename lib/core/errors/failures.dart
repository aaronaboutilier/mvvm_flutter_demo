import 'failure.dart';

/// Network-related failure (timeouts, connectivity, status codes).
class NetworkFailure extends Failure {
  final int? statusCode;
  const NetworkFailure({
    required String message,
    this.statusCode,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message: message, code: code ?? 'network', cause: cause, stackTrace: stackTrace);
}

/// Validation/business rule violation failure.
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;
  const ValidationFailure({
    required String message,
    this.fieldErrors,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message: message, code: code ?? 'validation', cause: cause, stackTrace: stackTrace);
}

/// Configuration-related failure (missing keys, invalid formats).
class ConfigFailure extends Failure {
  const ConfigFailure({
    required String message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message: message, code: code ?? 'config', cause: cause, stackTrace: stackTrace);
}

/// Missing resource failure.
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required String message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message: message, code: code ?? 'not_found', cause: cause, stackTrace: stackTrace);
}

/// Unknown/unclassified failure type to avoid exposing raw exceptions.
class UnknownFailure extends Failure {
  const UnknownFailure({
    required String message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(message: message, code: code ?? 'unknown', cause: cause, stackTrace: stackTrace);
}
