import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'presentation/dashboard_page.dart';

/// GoRouter routes exposed by the Dashboard feature.
List<RouteBase> featureDashboardRoutes() => [
      GoRoute(
        path: DashboardRoutes.path,
        name: DashboardRoutes.name,
        builder: (BuildContext context, GoRouterState state) => const DashboardPage(),
      ),
    ];

/// Typed route constants for the Dashboard feature.
class DashboardRoutes {
  static const String path = '/dashboard';
  static const String name = 'dashboard';
}

/// Simple navigation helpers for the Dashboard feature.
extension DashboardRouteHelper on BuildContext {
  void goToDashboard() => go(DashboardRoutes.path);
  void pushDashboard() => push(DashboardRoutes.path);
}
