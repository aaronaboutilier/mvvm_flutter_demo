abstract class AnalyticsService {
  Future<void> logEvent(String name, {Map<String, Object?> parameters});
}

class DebugAnalyticsService implements AnalyticsService {
  final List<Map<String, Object?>> events = [];

  @override
  Future<void> logEvent(String name, {Map<String, Object?> parameters = const {}}) async {
    events.add({'name': name, 'params': parameters});
  }
}
