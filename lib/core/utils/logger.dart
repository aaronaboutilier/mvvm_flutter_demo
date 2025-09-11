/// Structured logger interface for app-wide logging with context.
abstract class Logger {
  void debug(String message, {Map<String, Object?>? context});
  void info(String message, {Map<String, Object?>? context});
  void warning(String message, {Map<String, Object?>? context});
  void error(String message, {Object? exception, StackTrace? stackTrace, Map<String, Object?>? context});
}

/// Lightweight debug logger printing to console; replace with production logger as needed.
class DebugLogger implements Logger {
  const DebugLogger();

  @override
  void debug(String message, {Map<String, Object?>? context}) => _print('DEBUG', message, context: context);

  @override
  void info(String message, {Map<String, Object?>? context}) => _print('INFO', message, context: context);

  @override
  void warning(String message, {Map<String, Object?>? context}) => _print('WARN', message, context: context);

  @override
  void error(String message, {Object? exception, StackTrace? stackTrace, Map<String, Object?>? context}) {
    _print('ERROR', message, context: {
      if (context != null) ...context,
      if (exception != null) 'exception': exception.toString(),
      if (stackTrace != null) 'stackTrace': stackTrace.toString(),
    });
  }

  void _print(String level, String message, {Map<String, Object?>? context}) {
    final ctx = (context == null || context.isEmpty) ? '' : ' ' + context.toString();
    // ignore: avoid_print
    print('[$level] $message$ctx');
  }
}
