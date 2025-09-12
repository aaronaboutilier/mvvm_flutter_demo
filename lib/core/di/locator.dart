import 'package:get_it/get_it.dart';

// Home (migrated to feature_dashboard)
import '../../features/settings/application/usecases/settings_usecases.dart';
import '../../features/settings/infrastructure/repositories/config_settings_repository.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../configuration/configuration.dart';
import '../theming/theming.dart';
import '../accessibility/accessibility.dart';
import '../analytics/analytics.dart';
import '../../features/settings/presentation/viewmodels/settings_viewmodel.dart';
import '../../features/settings/presentation/viewmodels/settings_view_state.dart';
import '../core.dart';
import 'package:core_foundation/core/presentation/view_model.dart';
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

  // Settings feature
  locator.registerLazySingleton<SettingsRepository>(() => ConfigSettingsRepository(locator()));
  locator.registerFactory(() => UpdateThemeMode(locator()));
  locator.registerFactory(() => UpdateTextScale(locator()));
  locator.registerFactory(() => UpdateReduceAnimations(locator()));
  locator.registerFactory(() => UpdateHighContrast(locator()));
  locator.registerFactory(() => UpdateLargerTouchTargets(locator()));
  locator.registerFactory(() => UpdateVoiceGuidance(locator()));
  locator.registerFactory(() => UpdateHapticFeedback(locator()));
  locator.registerFactory(() => UpdateUseDeviceLocale(locator()));
  locator.registerFactory(() => UpdateLanguageCode(locator()));
  locator.registerFactory(() => ExportConfiguration(locator()));
  locator.registerFactory(() => ResetToDefaults(locator()));

  // Presentation: ViewModels
  locator.registerFactory<SettingsViewModel>(() => SettingsViewModel(
        repo: locator(),
        updateThemeMode: locator(),
        updateTextScale: locator(),
        updateReduceAnimations: locator(),
        updateHighContrast: locator(),
        updateLargerTouchTargets: locator(),
        updateVoiceGuidance: locator(),
        updateHapticFeedback: locator(),
        updateUseDeviceLocale: locator(),
        updateLanguageCode: locator(),
        exportConfiguration: locator(),
        resetToDefaults: locator(),
      ));

  // Interface registrations
  // Details ViewModel interface provided by feature_details
  locator.registerFactory<ViewModel<SettingsViewState>>(() => locator<SettingsViewModel>());

  // Feature packages: allow each feature to register its own dependencies
  feature_dashboard.registerFeatureDashboard(locator);
  feature_products.registerFeatureProducts(locator);
  feature_details.registerFeatureDetails(locator);
}
