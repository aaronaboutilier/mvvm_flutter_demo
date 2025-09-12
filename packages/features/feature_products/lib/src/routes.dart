import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'presentation/products_page.dart';

/// GoRouter routes exposed by the Products feature.
List<RouteBase> featureProductsRoutes() => [
      GoRoute(
        path: ProductsRoutes.path,
        name: ProductsRoutes.name,
        builder: (BuildContext context, GoRouterState state) => const ProductsPage(),
      ),
    ];

/// Typed route constants for the Products feature.
class ProductsRoutes {
  static const String path = '/products';
  static const String name = 'products';
}

/// Simple navigation helpers for the Products feature.
extension ProductsRouteHelper on BuildContext {
  void goToProducts() => go(ProductsRoutes.path);
  void pushProducts() => push(ProductsRoutes.path);
}
