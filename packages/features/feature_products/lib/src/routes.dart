import 'package:feature_products/src/presentation/products_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// GoRouter routes exposed by the Products feature.
List<RouteBase> featureProductsRoutes() => [
  GoRoute(
    path: ProductsRoutes.path,
    name: ProductsRoutes.name,
    builder: (BuildContext context, GoRouterState state) =>
        const ProductsPage(),
  ),
];

/// Typed route constants for the Products feature.
class ProductsRoutes {
  /// The path for the Products page.
  static const String path = '/products';

  /// The name for the Products page route.
  static const String name = 'products';
}

/// Simple navigation helpers for the Products feature.
extension ProductsRouteHelper on BuildContext {
  /// Navigates to the Products page.
  void goToProducts() => go(ProductsRoutes.path);

  /// Pushes the Products page onto the navigation stack.
  void pushProducts() => push(ProductsRoutes.path);
}
