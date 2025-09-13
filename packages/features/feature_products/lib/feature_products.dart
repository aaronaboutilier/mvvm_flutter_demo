// Barrel export to expose the package API surface.
// export 'src/domain/...';
// export 'src/application/...';
// Export presentation and routes API
// Export DI registration hook for the feature
export 'src/di.dart' show registerFeatureProducts;
export 'src/presentation/products_page.dart';
export 'src/routes.dart'
    show ProductsRouteHelper, ProductsRoutes, featureProductsRoutes;
