import 'package:feature_dashboard/src/presentation/dashboard_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// GoRouter routes exposed by the Dashboard feature.
List<RouteBase> featureDashboardRoutes() => [
  GoRoute(
    path: DashboardRoutes.path,
    name: DashboardRoutes.name,
    builder: (BuildContext context, GoRouterState state) =>
        const DashboardPage(),
  ),
];

/// Typed route constants for the Dashboard feature.
class DashboardRoutes {
  /// The dashboard route path.
  static const String path = '/dashboard';

  /// The dashboard route name.
  static const String name = 'dashboard';
}

/// Simple navigation helpers for the Dashboard feature.
extension DashboardRouteHelper on BuildContext {
  /// Navigates to the dashboard route.
  void goToDashboard() => go(DashboardRoutes.path);

  /// Pushes the dashboard route onto the navigation stack.
  void pushDashboard() => push(DashboardRoutes.path);
}
