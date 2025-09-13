/// Logs an analytics event.
Future<void> logEvent(
  String name, {
  Map<String, Object?> parameters = const {},
}) async {
  // Implement your analytics logic here.
}

/// Debug implementation that stores events in memory.
class DebugAnalyticsService {
  /// Creates a [DebugAnalyticsService].
  final List<Map<String, Object?>> events = [];

  /// Logs an analytics event and stores it in memory.
  Future<void> logEvent(
    String name, {
    Map<String, Object?> parameters = const {},
  }) async {
    events.add({'name': name, 'params': parameters});
  }
}
