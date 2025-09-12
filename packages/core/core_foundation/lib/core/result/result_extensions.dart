import '../errors/failure.dart';
import 'result.dart';

extension ResultX<T> on Result<T> {
  T? get valueOrNull => asSuccess?.value;
  Failure? get failureOrNull => asFailure?.failureValue;
}
