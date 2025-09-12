import 'package:get_it/get_it.dart';

import 'application/usecases/settings_usecases.dart';
import 'domain/repositories/settings_repository.dart';
import 'presentation/viewmodels/settings_viewmodel.dart';

/// Registers Settings feature dependencies into the provided GetIt locator.
/// Note: The repository implementation may live in the host app to adapt to its ConfigService.
void registerFeatureSettings(GetIt locator) {
  // Use cases
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

  // ViewModel
  locator.registerFactory<SettingsViewModel>(() => SettingsViewModel(
        repo: locator<SettingsRepository>(),
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
