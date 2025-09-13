import 'package:core_foundation/core/core.dart';
import 'package:feature_settings/src/domain/repositories/settings_repository.dart';
import 'package:feature_settings/src/domain/value_objects/language_code.dart';
import 'package:feature_settings/src/domain/value_objects/text_scale.dart';
import 'package:feature_settings/src/domain/value_objects/theme_preference.dart';

/// Use case for updating the theme mode preference.
class UpdateThemeMode {
  /// Creates an [UpdateThemeMode] use case.
  UpdateThemeMode(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to update the theme mode.
  Future<Result<void>> call(ThemePreference params) =>
      repo.updateThemeMode(params);
}

/// Use case for updating the text scale factor.
class UpdateTextScale {
  /// Creates an [UpdateTextScale] use case.
  UpdateTextScale(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to update the text scale factor.
  Future<Result<void>> call(TextScale params) =>
      repo.updateTextScaleFactor(params);
}

/// Use case for toggling reduced animations.
class UpdateReduceAnimations {
  /// Creates an [UpdateReduceAnimations] use case.
  UpdateReduceAnimations(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to update reduced animations.
  Future<Result<void>> call({required bool reduceAnimations}) =>
      repo.updateReduceAnimations(reduceAnimations: reduceAnimations);
}

/// Use case for toggling high contrast mode.
class UpdateHighContrast {
  /// Creates an [UpdateHighContrast] use case.
  UpdateHighContrast(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to update high contrast mode.
  Future<Result<void>> call({required bool highContrast}) =>
      repo.updateHighContrast(highContrast: highContrast);
}

/// Use case for toggling larger touch targets.
class UpdateLargerTouchTargets {
  /// Creates an [UpdateLargerTouchTargets] use case.
  UpdateLargerTouchTargets(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to update larger touch targets.
  Future<Result<void>> call({required bool largerTouchTargets}) =>
      repo.updateLargerTouchTargets(largerTouchTargets: largerTouchTargets);
}

/// Use case for toggling voice guidance.
class UpdateVoiceGuidance {
  /// Creates an [UpdateVoiceGuidance] use case.
  UpdateVoiceGuidance(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to update voice guidance.
  Future<Result<void>> call({required bool enableVoiceGuidance}) =>
      repo.updateVoiceGuidance(enableVoiceGuidance: enableVoiceGuidance);
}

/// Use case for toggling haptic feedback.
class UpdateHapticFeedback {
  /// Creates an [UpdateHapticFeedback] use case.
  UpdateHapticFeedback(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to update haptic feedback.
  Future<Result<void>> call({required bool enableHapticFeedback}) =>
      repo.updateHapticFeedback(enableHapticFeedback: enableHapticFeedback);
}

/// Use case for toggling use of device locale.
class UpdateUseDeviceLocale {
  /// Creates an [UpdateUseDeviceLocale] use case.
  UpdateUseDeviceLocale(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to update use of device locale.
  Future<Result<void>> call({required bool useDeviceLocale}) =>
      repo.updateUseDeviceLocale(useDeviceLocale: useDeviceLocale);
}

/// Use case for updating the explicit language code.
class UpdateLanguageCode {
  /// Creates an [UpdateLanguageCode] use case.
  UpdateLanguageCode(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to update the language code.
  Future<Result<void>> call(LanguageCode params) =>
      repo.updateLanguageCode(params);
}

/// Use case for exporting the current configuration.
class ExportConfiguration {
  /// Creates an [ExportConfiguration] use case.
  ExportConfiguration(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to export the configuration.
  Future<Result<String>> call(NoParams params) => repo.exportConfiguration();
}

/// Use case for resetting settings to default values.
class ResetToDefaults {
  /// Creates a [ResetToDefaults] use case.
  ResetToDefaults(this.repo);

  /// The settings repository.
  final SettingsRepository repo;

  /// Calls the use case to reset settings to defaults.
  Future<Result<void>> call(NoParams params) => repo.resetToDefaults();
}
