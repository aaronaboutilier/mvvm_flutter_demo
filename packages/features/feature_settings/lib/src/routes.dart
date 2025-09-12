import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'presentation/views/settings_page.dart';

/// GoRouter routes exposed by the Settings feature.
List<RouteBase> featureSettingsRoutes() => [
      GoRoute(
        path: SettingsRoutes.path,
        name: SettingsRoutes.name,
        builder: (BuildContext context, GoRouterState state) => const SettingsPage(),
      ),
    ];

class SettingsRoutes {
  static const String path = '/settings';
  static const String name = 'settings';
}

extension SettingsRouteHelper on BuildContext {
  void goToSettings() => go(SettingsRoutes.path);
  void pushSettings() => push(SettingsRoutes.path);
}
