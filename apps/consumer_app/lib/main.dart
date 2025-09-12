import 'package:feature_dashboard/feature_dashboard.dart';
import 'package:feature_products/feature_products.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// Entry point for the consumer app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Minimal DI wiring for feature packages
  final locator = GetIt.instance;
  registerFeatureDashboard(locator);
  registerFeatureProducts(locator);
  runApp(const ConsumerApp());
}

/// Minimal app that composes feature routes.
class ConsumerApp extends StatelessWidget {
  /// Creates the ConsumerApp widget.
  const ConsumerApp({super.key});

  /// Builds the root MaterialApp with GoRouter routes.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Consumer App',
      routerConfig: GoRouter(
        initialLocation: DashboardRoutes.path,
        routes: [
          ...featureDashboardRoutes(),
          ...featureProductsRoutes(),
        ],
      ),
    );
  }
}
