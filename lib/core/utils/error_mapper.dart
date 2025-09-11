import '../errors/failures.dart';
import '../errors/failure.dart';

/// Centralized mapper for converting exceptions to domain Failures.
class ErrorMapper {
  const ErrorMapper._();

  static Failure map(Object error, [StackTrace? stackTrace]) {
    // Extend this as infrastructure gets implemented (e.g., Dio/HTTP errors)
    if (error is Failure) return error;

    final msg = error.toString();

    // Heuristics for common cases without coupling to external libs
    if (msg.contains('SocketException') || msg.contains('Connection closed')) {
      return NetworkFailure(message: 'Network error', cause: error, stackTrace: stackTrace);
    }

    return UnknownFailure(message: 'Unexpected error', cause: error, stackTrace: stackTrace);
  }
}
