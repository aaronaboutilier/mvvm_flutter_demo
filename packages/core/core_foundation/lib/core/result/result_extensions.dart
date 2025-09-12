import '../errors/failure.dart';
import 'result.dart';

extension ResultX<T> on Result<T> {
  // Existing convenience getters
  T? get valueOrNull => asSuccess?.value;
  Failure? get failureOrNull => asFailure?.failureValue;

  // Backward-compatible helpers
  Result<R> map<R>(R Function(T v) fn) {
    final s = asSuccess;
    if (s != null) return Success<R>(fn(s.value));
    final f = asFailure!;
    return FailureResult<R>(f.failureValue);
  }

  Result<R> flatMap<R>(Result<R> Function(T v) fn) {
    final s = asSuccess;
    if (s != null) return fn(s.value);
    final f = asFailure!;
    return FailureResult<R>(f.failureValue);
  }

  T? getOrNull() => asSuccess?.value;

  T getOrElse(T Function() orElse) => asSuccess?.value ?? orElse();
}
