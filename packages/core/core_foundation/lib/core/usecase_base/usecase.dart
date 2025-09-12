import '../errors/failure.dart';
import '../result/result.dart';

abstract class UseCase<T, P> {
  Future<Result<T>> call(P params);
}

class NoParams {
  const NoParams();
}

class UnimplementedFailure extends Failure {
  const UnimplementedFailure(String message) : super(message: message, code: 'unimplemented');
}
