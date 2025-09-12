import '../errors/failure.dart';

abstract class Result<T> {
  const Result();
  R fold<R>({required R Function(Failure f) failure, required R Function(T v) success});
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;
  Success<T>? get asSuccess => this is Success<T> ? this as Success<T> : null;
  FailureResult<T>? get asFailure => this is FailureResult<T> ? this as FailureResult<T> : null;
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
  @override
  R fold<R>({required R Function(Failure f) failure, required R Function(T v) success}) => success(value);
  @override
  String toString() => 'Success($value)';
}

class FailureResult<T> extends Result<T> {
  final Failure failureValue;
  const FailureResult(this.failureValue);
  @override
  R fold<R>({required R Function(Failure f) failure, required R Function(T v) success}) => failure(failureValue);
  @override
  String toString() => 'FailureResult($failureValue)';
}
