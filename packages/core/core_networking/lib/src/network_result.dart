/// Represents the result of a network operation.
sealed class NetworkResult<T> {
  /// Creates a [NetworkResult].
  const NetworkResult();

  /// Pattern matching for [NetworkResult].
  R when<R>({
    required R Function(T) ok,
    required R Function(Object, int?) err,
  }) {
    final self = this;
    if (self is NetworkOk<T>) return ok(self.data);
    if (self is NetworkErr<T>) return err(self.error, self.statusCode);
    throw StateError('Unknown NetworkResult subtype');
  }
}

/// Represents a successful network result.
class NetworkOk<T> extends NetworkResult<T> {
  /// Creates a [NetworkOk] with the given [data].
  const NetworkOk(this.data);

  /// The returned data.
  final T data;
}

/// Represents a failed network result.
class NetworkErr<T> extends NetworkResult<T> {
  /// Creates a [NetworkErr] with the given [error] and optional [statusCode].
  const NetworkErr(this.error, [this.statusCode]);

  /// The error object.
  final Object error;

  /// Optional HTTP status code.
  final int? statusCode;
}
