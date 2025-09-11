sealed class NetworkResult<T> {
  const NetworkResult();

  R when<R>({required R Function(T) ok, required R Function(Object, int?) err}) {
    final self = this;
    if (self is NetworkOk<T>) return ok(self.data);
    if (self is NetworkErr<T>) return err(self.error, self.statusCode);
    throw StateError('Unknown NetworkResult subtype');
  }
}

class NetworkOk<T> extends NetworkResult<T> {
  final T data;
  const NetworkOk(this.data);
}

class NetworkErr<T> extends NetworkResult<T> {
  final Object error;
  final int? statusCode;
  const NetworkErr(this.error, [this.statusCode]);
}
