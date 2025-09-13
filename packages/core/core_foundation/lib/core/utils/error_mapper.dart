import 'package:core_foundation/core/errors/failure.dart';
import 'package:core_foundation/core/errors/failures.dart';

/// Utility for mapping errors to [Failure] types.
class ErrorMapper {
  /// Private constructor to prevent instantiation.
  const ErrorMapper._();

  /// Maps an [error] and optional [stackTrace] to a [Failure].
  static Failure map(Object error, [StackTrace? stackTrace]) {
    if (error is Failure) return error;
    final msg = error.toString();
    if (msg.contains('SocketException') || msg.contains('Connection closed')) {
      return NetworkFailure(
        message: 'Network error',
        cause: error,
        stackTrace: stackTrace,
      );
    }
    return UnknownFailure(
      message: 'Unexpected error',
      cause: error,
      stackTrace: stackTrace,
    );
  }
}
