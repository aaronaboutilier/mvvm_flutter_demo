import 'package:get_it/get_it.dart';

import '../../features/details/application/usecases/add_detail_item.dart';
import '../../features/details/application/usecases/clear_detail_items.dart';
import '../../features/details/application/usecases/get_detail_items.dart';
import '../../features/details/application/usecases/remove_detail_item.dart';
import '../../features/details/application/usecases/reorder_detail_items.dart';
import '../../features/details/infrastructure/repositories/in_memory_details_repository.dart';
// Home (migrated to feature_dashboard)
import '../../features/settings/application/usecases/settings_usecases.dart';
import '../../features/settings/infrastructure/repositories/config_settings_repository.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../configuration/configuration.dart';
import '../theming/theming.dart';
import '../accessibility/accessibility.dart';
import '../analytics/analytics.dart';
import '../../features/details/presentation/viewmodels/details_viewmodel.dart';
import '../../features/settings/presentation/viewmodels/settings_viewmodel.dart';
import '../../features/details/presentation/viewmodels/details_view_state.dart';
import '../../features/settings/presentation/viewmodels/settings_view_state.dart';
import '../core.dart';
// Feature package DI hooks
import 'package:feature_dashboard/feature_dashboard.dart' as feature_dashboard;
import 'package:feature_products/feature_products.dart' as feature_products;

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Core services
  locator.registerLazySingleton<ConfigService>(() => ConfigService.instance);
  locator.registerLazySingleton<ThemeService>(() => DefaultThemeService());
  locator.registerLazySingleton<AccessibilityService>(() => NoopAccessibilityService());
  locator.registerLazySingleton<AnalyticsService>(() => DebugAnalyticsService());
  // Logging & performance
  locator.registerLazySingleton<Logger>(() => const DebugLogger());
  locator.registerLazySingleton(() => PerformanceMonitor(locator()));

  // Details feature
  locator.registerLazySingleton(() => InMemoryDetailsRepository(locator()));
  locator.registerFactory(() => GetDetailItems(locator()));
  locator.registerFactory(() => AddDetailItem(locator()));
  locator.registerFactory(() => RemoveDetailItem(locator()));
  locator.registerFactory(() => ClearDetailItems(locator()));
  locator.registerFactory(() => ReorderDetailItems(locator()));

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
  locator.registerFactory<DetailsViewModel>(() => DetailsViewModel(
        getItems: locator(),
        addItem: locator(),
        removeItem: locator(),
        clearItems: locator(),
        reorderItems: locator(),
      ));
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
  locator.registerFactory<ViewModel<DetailsViewState>>(() => locator<DetailsViewModel>());
  locator.registerFactory<ViewModel<SettingsViewState>>(() => locator<SettingsViewModel>());

  // Feature packages: allow each feature to register its own dependencies
  feature_dashboard.registerFeatureDashboard(locator);
  feature_products.registerFeatureProducts(locator);
}
