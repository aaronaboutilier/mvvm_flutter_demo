import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'presentation/views/details_page.dart';

/// GoRouter routes exposed by the Details feature.
List<RouteBase> featureDetailsRoutes() => [
      GoRoute(
        path: DetailsRoutes.path,
        name: DetailsRoutes.name,
        builder: (BuildContext context, GoRouterState state) => const DetailsPage(),
      ),
    ];

/// Typed route constants for the Details feature.
class DetailsRoutes {
  static const String path = '/details';
  static const String name = 'details';
}

/// Simple navigation helpers for the Details feature.
extension DetailsRouteHelper on BuildContext {
  void goToDetails() => go(DetailsRoutes.path);
  void pushDetails() => push(DetailsRoutes.path);
}
