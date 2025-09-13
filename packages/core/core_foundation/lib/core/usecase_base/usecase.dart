import 'package:core_foundation/core/errors/failure.dart';
import 'package:core_foundation/core/result/result.dart';

/// Executes a use case with the given parameters.
Future<Result<T>> call<T, P>(
  Future<Result<T>> Function(P params) fn,
  P params,
) {
  return fn(params);
}

/// Represents no parameters for a use case.
class NoParams {
  /// Creates a [NoParams] instance.
  const NoParams();
}

/// Failure type for unimplemented use cases.
class UnimplementedFailure extends Failure {
  /// Creates an [UnimplementedFailure] with the given message.
  const UnimplementedFailure(String message)
    : super(message: message, code: 'unimplemented');
}
