import 'package:flutter/material.dart';

/// Cross-cutting analytics contract for the monorepo.
///
/// Implementations may forward to Firebase, Segment, custom backends, etc.
abstract class AnalyticsService {
  /// Logs a generic analytics event.
  Future<void> logEvent(
    String name, {
    Map<String, Object?> parameters = const <String, Object?>{},
  });

  /// Records a screen view (page view).
  Future<void> logScreenView(
    String screenName, {
    String? screenClass,
    Map<String, Object?> parameters = const <String, Object?>{},
  });

  /// Records a navigation event between routes.
  Future<void> logNavigation({
    required String to,
    String? from,
    Map<String, Object?> parameters = const <String, Object?>{},
  });
}

/// Global access to the configured analytics service.
///
/// This avoids adding a DI dependency in core packages. Apps should set
/// the analytics backend during startup to install a concrete service.
class Analytics {
  Analytics._();

  static AnalyticsService? _service;

  /// The active analytics service. Falls back to a debug implementation.
  static AnalyticsService get instance => _service ??= DebugAnalyticsService();

  /// Installs the global analytics service (call once during app startup).
  static set backend(AnalyticsService service) => _service = service;

  /// Returns the currently installed analytics service, if any.
  static AnalyticsService? get backend => _service;

  /// Wraps a synchronous action so it logs [eventName] before executing.
  static VoidCallback trackedAction(
    String eventName,
    VoidCallback action, {
    Map<String, Object?> Function()? parameters,
  }) {
    return () {
      // Intentionally fire-and-forget.
      // ignore: discarded_futures
      instance.logEvent(eventName, parameters: parameters?.call() ?? const {});
      action();
    };
  }

  /// Wraps an async action so it logs [eventName] before executing.
  static Future<void> Function() trackedAsyncAction(
    String eventName,
    Future<void> Function() action, {
    Map<String, Object?> Function()? parameters,
  }) {
    return () async {
      await instance.logEvent(
        eventName,
        parameters: parameters?.call() ?? const {},
      );
      await action();
    };
  }
}

/// Navigator observer that logs navigation and screen views.
class AnalyticsNavigatorObserver extends NavigatorObserver {
  /// Creates an observer that uses [service] to log events.
  AnalyticsNavigatorObserver(this.service);

  /// Analytics backend.
  final AnalyticsService service;

  String? _routeName(Route<dynamic>? route) {
    final settings = route?.settings;
    final name = settings?.name;
    if (name != null && name.isNotEmpty) return name;
    // Fallback to runtime type or a generic label.
    return settings?.name ?? route?.settings.runtimeType.toString();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final to = _routeName(route) ?? 'unknown';
    final from = _routeName(previousRoute);
    // ignore: discarded_futures
    service
      ..logNavigation(to: to, from: from)
      // ignore: discarded_futures
      ..logScreenView(to);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final to = _routeName(newRoute) ?? 'unknown';
    final from = _routeName(oldRoute);
    // ignore: discarded_futures
    service
      ..logNavigation(to: to, from: from, parameters: const {'op': 'replace'})
      // ignore: discarded_futures
      ..logScreenView(to);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final from = _routeName(route);
    final to = _routeName(previousRoute) ?? 'unknown';
    // ignore: discarded_futures
    service
      ..logNavigation(to: to, from: from, parameters: const {'op': 'pop'})
      // ignore: discarded_futures
      ..logScreenView(to);
  }
}

/// Debug implementation that stores events in memory and prints to console.
class DebugAnalyticsService implements AnalyticsService {
  /// In-memory event log for tests and debug sessions.
  final List<Map<String, Object?>> events = <Map<String, Object?>>[];

  @override
  Future<void> logEvent(
    String name, {
    Map<String, Object?> parameters = const <String, Object?>{},
  }) async {
    final record = <String, Object?>{
      'type': 'event',
      'name': name,
      'parameters': parameters,
    };
    events.add(record);
    debugPrint('[analytics] $record');
  }

  @override
  Future<void> logNavigation({
    required String to,
    String? from,
    Map<String, Object?> parameters = const <String, Object?>{},
  }) async {
    final record = <String, Object?>{
      'type': 'navigation',
      'to': to,
      if (from != null) 'from': from,
      'parameters': parameters,
    };
    events.add(record);
    debugPrint('[analytics] $record');
  }

  @override
  Future<void> logScreenView(
    String screenName, {
    String? screenClass,
    Map<String, Object?> parameters = const <String, Object?>{},
  }) async {
    final record = <String, Object?>{
      'type': 'screen_view',
      'screenName': screenName,
      if (screenClass != null) 'screenClass': screenClass,
      'parameters': parameters,
    };
    events.add(record);
    debugPrint('[analytics] $record');
  }
}

/// Convenience top-level helper that forwards to the global [Analytics].
Future<void> logEvent(
  String name, {
  Map<String, Object?> parameters = const <String, Object?>{},
}) async {
  await Analytics.instance.logEvent(name, parameters: parameters);
}

// ---------- Ergonomic extensions for tracked callbacks ----------

/// Adds `withAnalytics` helpers to callbacks for concise tracking.
extension AnalyticsCallbackX on VoidCallback {
  /// Returns a new callback that logs [eventName] before invoking this.
  VoidCallback withAnalytics(
    String eventName, {
    Map<String, Object?> Function()? parameters,
  }) => Analytics.trackedAction(eventName, this, parameters: parameters);
}

/// Adds `withAnalyticsAsync` helper to async actions.
extension AnalyticsAsyncCallbackX on Future<void> Function() {
  /// Returns a new async callback that logs [eventName] before invoking this.
  Future<void> Function() withAnalyticsAsync(
    String eventName, {
    Map<String, Object?> Function()? parameters,
  }) => Analytics.trackedAsyncAction(eventName, this, parameters: parameters);
}
