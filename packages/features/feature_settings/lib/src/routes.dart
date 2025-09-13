import 'package:feature_settings/src/presentation/views/settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// GoRouter routes exposed by the Settings feature.
List<RouteBase> featureSettingsRoutes() => [
  GoRoute(
    path: SettingsRoutes.path,
    name: SettingsRoutes.name,
    builder: (BuildContext context, GoRouterState state) =>
        const SettingsPage(),
  ),
];

/// Typed route constants for the Settings feature.
class SettingsRoutes {
  /// Path for the Settings page.
  static const String path = '/settings';

  /// Name for the Settings page route.
  static const String name = 'settings';
}

/// Simple navigation helpers for the Settings feature.
extension SettingsRouteHelper on BuildContext {
  /// Navigates to the Settings page.
  void goToSettings() => go(SettingsRoutes.path);

  /// Pushes the Settings page onto the navigation stack.
  void pushSettings() => push(SettingsRoutes.path);
}
