import 'package:feature_settings/src/application/usecases/settings_usecases.dart';
import 'package:feature_settings/src/domain/repositories/settings_repository.dart';
import 'package:feature_settings/src/presentation/viewmodels/settings_viewmodel.dart';
import 'package:get_it/get_it.dart';

/// Registers Settings feature dependencies into the provided GetIt locator.
/// Note: The repository implementation may live in the host app to adapt to its
/// ConfigService.
void registerFeatureSettings(GetIt locator) {
  // Use cases
  locator
    ..registerFactory(() => UpdateThemeMode(locator()))
    ..registerFactory(() => UpdateTextScale(locator()))
    ..registerFactory(() => UpdateReduceAnimations(locator()))
    ..registerFactory(() => UpdateHighContrast(locator()))
    ..registerFactory(() => UpdateLargerTouchTargets(locator()))
    ..registerFactory(() => UpdateVoiceGuidance(locator()))
    ..registerFactory(() => UpdateHapticFeedback(locator()))
    ..registerFactory(() => UpdateUseDeviceLocale(locator()))
    ..registerFactory(() => UpdateLanguageCode(locator()))
    ..registerFactory(() => ExportConfiguration(locator()))
    ..registerFactory(() => ResetToDefaults(locator()))
    // ViewModel
    ..registerFactory<SettingsViewModel>(
      () => SettingsViewModel(
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
      ),
    );
}
