// Barrel export to expose the package API surface.
// export 'src/domain/...';
// export 'src/application/...';
// Export presentation and routes API
export 'src/presentation/products_page.dart';
export 'src/routes.dart' show featureProductsRoutes, ProductsRoutes, ProductsRouteHelper;
// Export DI registration hook for the feature
export 'src/di.dart' show registerFeatureProducts;
