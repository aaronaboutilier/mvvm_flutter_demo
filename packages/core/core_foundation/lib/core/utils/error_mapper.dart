import '../errors/failure.dart';
import '../errors/failures.dart';

class ErrorMapper {
  const ErrorMapper._();

  static Failure map(Object error, [StackTrace? stackTrace]) {
    if (error is Failure) return error;
    final msg = error.toString();
    if (msg.contains('SocketException') || msg.contains('Connection closed')) {
      return NetworkFailure(message: 'Network error', cause: error, stackTrace: stackTrace);
    }
    return UnknownFailure(message: 'Unexpected error', cause: error, stackTrace: stackTrace);
  }
}
