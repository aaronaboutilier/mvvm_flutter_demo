import 'package:core_foundation/core/result/result.dart';
import 'package:core_foundation/core/utils/error_mapper.dart';

/// A shorthand for an asynchronous [Result].
typedef ResultAsync<T> = Future<Result<T>>;

/// Extension methods for [ResultAsync].
extension ResultAsyncX<T> on ResultAsync<T> {
  /// Maps the success value asynchronously.
  Future<Result<R>> mapAsync<R>(Future<R> Function(T v) fn) async {
    final r = await this;
    final s = r.asSuccess;
    if (s != null) {
      final mapped = await fn(s.value);
      return Success<R>(mapped);
    }
    return FailureResult<R>(r.asFailure!.failureValue);
  }

  /// Flat maps the success value asynchronously.
  Future<Result<R>> flatMapAsync<R>(Future<Result<R>> Function(T v) fn) async {
    final r = await this;
    final s = r.asSuccess;
    if (s != null) return fn(s.value);
    return FailureResult<R>(r.asFailure!.failureValue);
  }

  /// Returns the success value or computes an alternative asynchronously.
  Future<T> getOrElseAsync(Future<T> Function() orElse) async {
    final r = await this;
    return r.asSuccess?.value ?? await orElse();
  }
}

/// Guard to convert exceptions into Failure-wrapped Results consistently.
Future<Result<T>> resultGuard<T>(Future<T> Function() op) async {
  try {
    final v = await op();
    return Result.ok(v);
  } catch (e, st) {
    final f = ErrorMapper.map(e, st);
    return Result.err<T>(f);
  }
}

/// Synchronous guard version.
Result<T> resultGuardSync<T>(T Function() op) {
  try {
    final v = op();
    return Result.ok(v);
  } catch (e, st) {
    final f = ErrorMapper.map(e, st);
    return Result.err<T>(f);
  }
}
