/// Logger interface for structured logging.
abstract class Logger {
  /// Logs a debug message.
  void debug(String message, {Map<String, Object?>? context});

  /// Logs an informational message.
  void info(String message, {Map<String, Object?>? context});

  /// Logs a warning message.
  void warning(String message, {Map<String, Object?>? context});

  /// Logs an error message with optional exception and stack trace.
  void error(
    String message, {
    Object? exception,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  });
}

/// Debug logger implementation that prints to console.
class DebugLogger implements Logger {
  /// Creates a [DebugLogger].
  const DebugLogger();

  /// Logs a debug message.
  @override
  void debug(String message, {Map<String, Object?>? context}) =>
      _print('DEBUG', message, context: context);

  /// Logs an informational message.
  @override
  void info(String message, {Map<String, Object?>? context}) =>
      _print('INFO', message, context: context);

  /// Logs a warning message.
  @override
  void warning(String message, {Map<String, Object?>? context}) =>
      _print('WARN', message, context: context);

  /// Logs an error message with optional exception and stack trace.
  @override
  void error(
    String message, {
    Object? exception,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    _print(
      'ERROR',
      message,
      context: {
        if (context != null) ...context,
        if (exception != null) 'exception': exception.toString(),
        if (stackTrace != null) 'stackTrace': stackTrace.toString(),
      },
    );
  }

  /// Prints the log message to the console.
  void _print(String level, String message, {Map<String, Object?>? context}) {
    final ctx = (context == null || context.isEmpty) ? '' : ' $context';
    // ignore: avoid_print
    print('[$level] $message$ctx');
  }
}
