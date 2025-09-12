/// Base domain failure carrying a message and optional details.
class Failure implements Exception {
  final String message;
  final String? code;
  final Object? cause;
  final StackTrace? stackTrace;

  const Failure({required this.message, this.code, this.cause, this.stackTrace});

  @override
  String toString() => 'Failure(code: '+(code ?? 'unknown')+', message: '+message+')';
}
