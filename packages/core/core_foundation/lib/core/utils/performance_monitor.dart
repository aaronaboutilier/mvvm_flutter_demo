import 'package:core_foundation/core/utils/logger.dart';

/// Utility for measuring and logging the duration of async operations.
class PerformanceMonitor {
  /// Creates a [PerformanceMonitor] that logs via the provided [_logger].
  const PerformanceMonitor(this._logger);

  final Logger _logger;

  /// Tracks the execution time of [operation] labeled by [operationName],
  /// logs the outcome, and returns the operation result.
  Future<T> track<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    final sw = Stopwatch()..start();
    try {
      final result = await operation();
      _logger.info(
        'Operation completed',
        context: {
          'operation': operationName,
          'durationMs': sw.elapsedMilliseconds,
          'success': true,
        },
      );
      return result;
    } catch (e, st) {
      _logger.error(
        'Operation failed',
        exception: e,
        stackTrace: st,
        context: {
          'operation': operationName,
          'durationMs': sw.elapsedMilliseconds,
          'success': false,
        },
      );
      rethrow;
    }
  }
}
