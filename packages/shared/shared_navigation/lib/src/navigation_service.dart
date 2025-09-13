import 'package:flutter/widgets.dart';

/// Interface for navigation services.
abstract class NavigationService {
  /// Navigates to [location], optionally passing [extra] arguments.
  Future<void> go(String location, {Object? extra});

  /// Pushes a new route for [location], optionally passing [extra] arguments.
  Future<void> push(String location, {Object? extra});

  /// Pops the current route, optionally returning [result].
  void pop<T extends Object?>([T? result]);
}

/// Implementation of [NavigationService] using a [GlobalKey<NavigatorState>].
class NavigatorKeyNavigationService implements NavigationService {
  /// Creates a [NavigatorKeyNavigationService] with the given [navigatorKey].
  NavigatorKeyNavigationService(this.navigatorKey);

  /// The navigator key used for navigation.
  final GlobalKey<NavigatorState> navigatorKey;

  /// Navigates to [location], removing all previous routes.
  @override
  Future<void> go(String location, {Object? extra}) async {
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      location,
      (route) => false,
      arguments: extra,
    );
  }

  /// Pushes a new route for [location].
  @override
  Future<void> push(String location, {Object? extra}) async {
    await navigatorKey.currentState?.pushNamed(location, arguments: extra);
  }

  /// Pops the current route.
  @override
  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }
}
