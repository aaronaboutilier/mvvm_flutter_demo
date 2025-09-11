import 'package:get_it/get_it.dart';

import '../../features/details/application/usecases/add_detail_item.dart';
import '../../features/details/application/usecases/clear_detail_items.dart';
import '../../features/details/application/usecases/get_detail_items.dart';
import '../../features/details/application/usecases/remove_detail_item.dart';
import '../../features/details/application/usecases/reorder_detail_items.dart';
import '../../features/details/infrastructure/repositories/in_memory_details_repository.dart';
import '../../features/home/application/usecases/clear_user.dart';
import '../../features/home/application/usecases/load_user.dart';
import '../../features/home/infrastructure/repositories/in_memory_user_repository.dart';
import '../../features/settings/application/usecases/settings_usecases.dart';
import '../../features/settings/infrastructure/repositories/config_settings_repository.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../configuration/configuration.dart';
import '../../features/home/presentation/viewmodels/home_viewmodel.dart';
import '../../features/details/presentation/viewmodels/details_viewmodel.dart';
import '../../features/settings/presentation/viewmodels/settings_viewmodel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Core services
  locator.registerLazySingleton<ConfigService>(() => ConfigService.instance);

  // Details feature
  locator.registerLazySingleton(() => InMemoryDetailsRepository());
  locator.registerFactory(() => GetDetailItems(locator()));
  locator.registerFactory(() => AddDetailItem(locator()));
  locator.registerFactory(() => RemoveDetailItem(locator()));
  locator.registerFactory(() => ClearDetailItems(locator()));
  locator.registerFactory(() => ReorderDetailItems(locator()));

  // Home feature
  locator.registerLazySingleton(() => InMemoryUserRepository());
  locator.registerFactory(() => LoadUser(locator()));
  locator.registerFactory(() => ClearUser(locator()));

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
  locator.registerFactory(() => HomeViewModel(
        loadUser: locator(),
        clearUser: locator(),
      ));
  locator.registerFactory(() => DetailsViewModel(
        getItems: locator(),
        addItem: locator(),
        removeItem: locator(),
        clearItems: locator(),
        reorderItems: locator(),
      ));
  locator.registerFactory(() => SettingsViewModel(
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
}
