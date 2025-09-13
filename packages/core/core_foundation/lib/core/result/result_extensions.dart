import 'package:core_foundation/core/errors/failure.dart';
import 'package:core_foundation/core/result/result.dart';

/// Extension providing convenience methods for [Result].
extension ResultX<T> on Result<T> {
  /// Gets the success value or null.
  T? get valueOrNull => asSuccess?.value;

  /// Gets the failure or null.
  Failure? get failureOrNull => asFailure?.failureValue;

  /// Maps the success value to a new [Result].
  Result<R> map<R>(R Function(T v) fn) {
    final s = asSuccess;
    if (s != null) return Success<R>(fn(s.value));
    final f = asFailure!;
    return FailureResult<R>(f.failureValue);
  }

  /// Flat maps the success value to a new [Result].
  Result<R> flatMap<R>(Result<R> Function(T v) fn) {
    final s = asSuccess;
    if (s != null) return fn(s.value);
    final f = asFailure!;
    return FailureResult<R>(f.failureValue);
  }

  /// Gets the success value or null.
  T? getOrNull() => asSuccess?.value;

  /// Gets the success value or computes a fallback.
  T getOrElse(T Function() orElse) => asSuccess?.value ?? orElse();

  /// Maps the failure value to a new [Result].
  Result<T> mapFailure(Failure Function(Failure f) fn) {
    final f = asFailure;
    if (f != null) return FailureResult<T>(fn(f.failureValue));
    return this;
  }

  /// Executes [fn] if the result is success.
  Result<T> tap(void Function(T v) fn) {
    final s = asSuccess;
    if (s != null) fn(s.value);
    return this;
  }

  /// Executes [fn] if the result is failure.
  Result<T> tapFailure(void Function(Failure f) fn) {
    final f = asFailure;
    if (f != null) fn(f.failureValue);
    return this;
  }

  /// Recovers from failure by providing a fallback value.
  Result<T> recover(T Function(Failure f) fallback) {
    final f = asFailure;
    if (f != null) return Success<T>(fallback(f.failureValue));
    return this;
  }

  /// Gets the success value or throws the failure.
  T getOrThrow([Failure Function(Failure f)? map]) {
    final s = asSuccess;
    if (s != null) return s.value;
    final f = asFailure!.failureValue;
    throw map?.call(f) ?? f;
  }

  /// Converts the result to a nullable value.
  T? toNullable() => asSuccess?.value;
}
