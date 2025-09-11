import '../errors/failure.dart';
import '../result/result.dart';

/// Base Use Case contract. All use cases should implement this interface.
abstract class UseCase<T, P> {
  Future<Result<T>> call(P params);
}

/// A convenience type for use cases that do not require params.
class NoParams {
  const NoParams();
}

/// A convenience failure for unimplemented or unsupported use cases.
class UnimplementedFailure extends Failure {
  const UnimplementedFailure(String message)
      : super(message: message, code: 'unimplemented');
}
