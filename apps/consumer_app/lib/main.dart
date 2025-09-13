import 'package:consumer_app/settings/consumer_settings_repository.dart';
import 'package:core_foundation/core/core.dart';
import 'package:feature_dashboard/feature_dashboard.dart';
import 'package:feature_details/feature_details.dart';
import 'package:feature_products/feature_products.dart';
import 'package:feature_settings/feature_settings.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// Entry point for the consumer app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Minimal DI wiring for feature packages
  final locator = GetIt.instance;
  // Core utilities required by feature packages
  if (!locator.isRegistered<Logger>()) {
    locator.registerLazySingleton<Logger>(() => const DebugLogger());
  }
  if (!locator.isRegistered<PerformanceMonitor>()) {
    locator.registerLazySingleton(() => PerformanceMonitor(locator()));
  }
  // App-provided repositories/bridges for features
  if (!locator.isRegistered<SettingsRepository>()) {
    locator.registerLazySingleton<SettingsRepository>(
      ConsumerSettingsRepository.new,
    );
  }
  registerFeatureDashboard(locator);
  registerFeatureProducts(locator);
  registerFeatureDetails(locator);
  registerFeatureSettings(locator);
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
          ...featureDetailsRoutes(),
          ...featureSettingsRoutes(),
        ],
      ),
    );
  }
}
