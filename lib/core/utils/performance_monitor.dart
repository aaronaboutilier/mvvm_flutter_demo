import 'logger.dart';

class PerformanceMonitor {
  final Logger _logger;
  const PerformanceMonitor(this._logger);

  Future<T> track<T>(String operationName, Future<T> Function() operation) async {
    final sw = Stopwatch()..start();
    try {
      final result = await operation();
      _logger.info('Operation completed', context: {
        'operation': operationName,
        'durationMs': sw.elapsedMilliseconds,
        'success': true,
      });
      return result;
    } catch (e, st) {
      _logger.error('Operation failed', exception: e, stackTrace: st, context: {
        'operation': operationName,
        'durationMs': sw.elapsedMilliseconds,
        'success': false,
      });
      rethrow;
    }
  }
}
