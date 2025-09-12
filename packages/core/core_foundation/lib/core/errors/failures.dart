import 'failure.dart';

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.cause, super.stackTrace}) : super(code: 'unknown');
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.cause, super.stackTrace}) : super(code: 'network');
}
