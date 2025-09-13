import 'package:core_foundation/core/errors/failure.dart';

/// Represents a result that can be either a success or a failure.
abstract class Result<T> {
  /// Creates a [Result].
  const Result();

  /// Folds the result into either a failure or success value.
  R fold<R>({
    required R Function(Failure f) failure,
    required R Function(T v) success,
  });

  /// Returns true if the result is a success.
  bool get isSuccess => this is Success<T>;

  /// Returns true if the result is a failure.
  bool get isFailure => this is FailureResult<T>;

  /// Returns the success value if present, otherwise null.
  Success<T>? get asSuccess => this is Success<T> ? this as Success<T> : null;

  /// Returns the failure value if present, otherwise null.
  FailureResult<T>? get asFailure =>
      this is FailureResult<T> ? this as FailureResult<T> : null;

  /// Creates a [Success] result.
  static Result<T> ok<T>(T value) => Success<T>(value);

  /// Creates a [FailureResult] result.
  static Result<T> err<T>(Failure failure) => FailureResult<T>(failure);

  /// Creates a [Result] from a nullable value, mapping null to a failure.
  static Result<T> fromNullable<T>(T? value, Failure ifNull) =>
      value == null ? FailureResult<T>(ifNull) : Success<T>(value);
}

/// Represents a successful result.
class Success<T> extends Result<T> {
  /// Creates a [Success] result.
  const Success(this.value);

  /// The success value.
  final T value;

  /// Folds the result into either a failure or success value.
  @override
  R fold<R>({
    required R Function(Failure f) failure,
    required R Function(T v) success,
  }) => success(value);

  /// Returns a string representation of the success.
  @override
  String toString() => 'Success($value)';
}

/// Represents a failed result.
class FailureResult<T> extends Result<T> {
  /// Creates a [FailureResult].
  const FailureResult(this.failureValue);

  /// The failure value.
  final Failure failureValue;

  /// Folds the result into either a failure or success value.
  @override
  R fold<R>({
    required R Function(Failure f) failure,
    required R Function(T v) success,
  }) => failure(failureValue);

  /// Returns a string representation of the failure.
  @override
  String toString() => 'FailureResult($failureValue)';
}
