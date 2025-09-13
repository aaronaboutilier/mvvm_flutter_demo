import 'package:core_foundation/core/core.dart';
import 'package:feature_settings/src/domain/entities/settings_config.dart';
import 'package:feature_settings/src/domain/value_objects/language_code.dart';
import 'package:feature_settings/src/domain/value_objects/text_scale.dart';
import 'package:feature_settings/src/domain/value_objects/theme_preference.dart';

/// Repository contract for reading and updating settings.
abstract class SettingsRepository {
  /// The most recently known settings configuration.
  SettingsConfig get currentConfig;

  /// Update the theme mode preference.
  Future<Result<void>> updateThemeMode(ThemePreference newThemeMode);

  /// Update the text scale factor preference.
  Future<Result<void>> updateTextScaleFactor(TextScale newScaleFactor);

  /// Toggle reduced animations.
  Future<Result<void>> updateReduceAnimations({required bool reduceAnimations});

  /// Toggle high contrast mode.
  Future<Result<void>> updateHighContrast({required bool highContrast});

  /// Toggle larger touch targets.
  Future<Result<void>> updateLargerTouchTargets({
    required bool largerTouchTargets,
  });

  /// Toggle voice guidance.
  Future<Result<void>> updateVoiceGuidance({required bool enableVoiceGuidance});

  /// Toggle haptic feedback.
  Future<Result<void>> updateHapticFeedback({
    required bool enableHapticFeedback,
  });

  /// Toggle using the device locale automatically.
  Future<Result<void>> updateUseDeviceLocale({required bool useDeviceLocale});

  /// Update the explicit language code to use.
  Future<Result<void>> updateLanguageCode(LanguageCode languageCode);

  /// Export the current configuration, returning the file path on success.
  Future<Result<String>> exportConfiguration();

  /// Reset settings back to default values.
  Future<Result<void>> resetToDefaults();

  /// Whether a feature flag is enabled for the provided [featureName].
  bool isFeatureEnabled(String featureName);
}
