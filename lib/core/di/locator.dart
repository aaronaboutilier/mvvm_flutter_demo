import 'package:get_it/get_it.dart';

// Home (migrated to feature_dashboard)
// Settings feature migrated to package
import 'package:feature_settings/feature_settings.dart' as feature_settings;
import '../../features/settings/infrastructure/repositories/config_settings_repository_adapter.dart';
import '../configuration/configuration.dart';
import '../theming/theming.dart';
import '../accessibility/accessibility.dart';
import '../analytics/analytics.dart';
// Presentation types come from feature_settings now
import '../core.dart';
// Feature package DI hooks
import 'package:feature_dashboard/feature_dashboard.dart' as feature_dashboard;
import 'package:feature_products/feature_products.dart' as feature_products;
import 'package:feature_details/feature_details.dart' as feature_details;

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Core services
  locator.registerLazySingleton<ConfigService>(() => ConfigService.instance);
  locator.registerLazySingleton<ThemeService>(() => DefaultThemeService());
  locator.registerLazySingleton<AccessibilityService>(() => DefaultAccessibilityService(locator()));
  locator.registerLazySingleton<AnalyticsService>(() => DebugAnalyticsService());
  // Logging & performance
  locator.registerLazySingleton<Logger>(() => const DebugLogger());
  locator.registerLazySingleton(() => PerformanceMonitor(locator()));

  // Details feature DI now registered via feature_details

  // Home/Dashboard feature registrations now live in feature_dashboard.registerFeatureDashboard

  // Settings feature: repository adapter implements package contract
  locator.registerLazySingleton<feature_settings.SettingsRepository>(() => ConfigSettingsRepositoryAdapter(locator()));
  // Let the feature register its use cases and view model
  feature_settings.registerFeatureSettings(locator);

  // Feature packages: allow each feature to register its own dependencies
  feature_dashboard.registerFeatureDashboard(locator);
  feature_products.registerFeatureProducts(locator);
  feature_details.registerFeatureDetails(locator);
  // feature_settings handled above
}
