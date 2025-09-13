import 'package:feature_details/src/presentation/views/details_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

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
  /// The details route path.
  static const String path = '/details';

  /// The details route name.
  static const String name = 'details';
}

/// Simple navigation helpers for the Details feature.
extension DetailsRouteHelper on BuildContext {
  /// Navigates to the details route.
  void goToDetails() => go(DetailsRoutes.path);

  /// Pushes the details route onto the navigation stack.
  void pushDetails() => push(DetailsRoutes.path);
}
