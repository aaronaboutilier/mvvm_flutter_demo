import 'package:core_foundation/core/core.dart';
import 'package:feature_settings/feature_settings.dart';
import 'package:flutter/material.dart';

/// Simple in-memory implementation of [SettingsRepository] for the demo app.
class ConsumerSettingsRepository extends ChangeNotifier
    implements SettingsRepository {
  ///
  ConsumerSettingsRepository()
    : _config = const SettingsConfig(
        theme: ThemeSettings(themeMode: ThemeMode.system, textScaleFactor: 1),
        accessibility: AccessibilitySettings(
          reduceAnimations: false,
          increasedContrast: false,
          largerTouchTargets: false,
          enableVoiceGuidance: false,
          enableHapticFeedback: true,
        ),
        localization: LocalizationSettings(
          useDeviceLocale: true,
          languageCode: 'en',
        ),
        brand: BrandInfo(
          appName: 'Consumer App',
          websiteUrl: 'https://example.com',
          supportEmail: 'support@example.com',
        ),
        features: FeatureSettings(enableDataExport: true),
      );

  SettingsConfig _config;

  @override
  SettingsConfig get currentConfig => _config;

  @override
  Future<Result<void>> updateThemeMode(ThemePreference newThemeMode) async {
    final mode = switch (newThemeMode) {
      ThemePreference.light => ThemeMode.light,
      ThemePreference.dark => ThemeMode.dark,
      ThemePreference.system => ThemeMode.system,
    };
    _config = SettingsConfig(
      theme: _config.theme.copyWith(themeMode: mode),
      accessibility: _config.accessibility,
      localization: _config.localization,
      brand: _config.brand,
      features: _config.features,
    );
    notifyListeners();
    return const Success(null);
  }

  @override
  Future<Result<void>> updateTextScaleFactor(TextScale newScaleFactor) async {
    _config = SettingsConfig(
      theme: _config.theme.copyWith(textScaleFactor: newScaleFactor.value),
      accessibility: _config.accessibility,
      localization: _config.localization,
      brand: _config.brand,
      features: _config.features,
    );
    notifyListeners();
    return const Success(null);
  }

  @override
  Future<Result<void>> updateReduceAnimations({
    required bool reduceAnimations,
  }) async {
    _config = SettingsConfig(
      theme: _config.theme,
      accessibility: _config.accessibility.copyWith(
        reduceAnimations: reduceAnimations,
      ),
      localization: _config.localization,
      brand: _config.brand,
      features: _config.features,
    );
    notifyListeners();
    return const Success(null);
  }

  @override
  Future<Result<void>> updateHighContrast({required bool highContrast}) async {
    _config = SettingsConfig(
      theme: _config.theme,
      accessibility: _config.accessibility.copyWith(
        increasedContrast: highContrast,
      ),
      localization: _config.localization,
      brand: _config.brand,
      features: _config.features,
    );
    notifyListeners();
    return const Success(null);
  }

  @override
  Future<Result<void>> updateLargerTouchTargets({
    required bool largerTouchTargets,
  }) async {
    _config = SettingsConfig(
      theme: _config.theme,
      accessibility: _config.accessibility.copyWith(
        largerTouchTargets: largerTouchTargets,
      ),
      localization: _config.localization,
      brand: _config.brand,
      features: _config.features,
    );
    notifyListeners();
    return const Success(null);
  }

  @override
  Future<Result<void>> updateVoiceGuidance({
    required bool enableVoiceGuidance,
  }) async {
    _config = SettingsConfig(
      theme: _config.theme,
      accessibility: _config.accessibility.copyWith(
        enableVoiceGuidance: enableVoiceGuidance,
      ),
      localization: _config.localization,
      brand: _config.brand,
      features: _config.features,
    );
    notifyListeners();
    return const Success(null);
  }

  @override
  Future<Result<void>> updateHapticFeedback({
    required bool enableHapticFeedback,
  }) async {
    _config = SettingsConfig(
      theme: _config.theme,
      accessibility: _config.accessibility.copyWith(
        enableHapticFeedback: enableHapticFeedback,
      ),
      localization: _config.localization,
      brand: _config.brand,
      features: _config.features,
    );
    notifyListeners();
    return const Success(null);
  }

  @override
  Future<Result<void>> updateUseDeviceLocale({
    required bool useDeviceLocale,
  }) async {
    _config = SettingsConfig(
      theme: _config.theme,
      accessibility: _config.accessibility,
      localization: _config.localization.copyWith(
        useDeviceLocale: useDeviceLocale,
      ),
      brand: _config.brand,
      features: _config.features,
    );
    notifyListeners();
    return const Success(null);
  }

  @override
  Future<Result<void>> updateLanguageCode(LanguageCode languageCode) async {
    _config = SettingsConfig(
      theme: _config.theme,
      accessibility: _config.accessibility,
      localization: _config.localization.copyWith(
        languageCode: languageCode.value,
      ),
      brand: _config.brand,
      features: _config.features,
    );
    notifyListeners();
    return const Success(null);
  }

  @override
  Future<Result<String>> exportConfiguration() async {
    // For the demo, just return a fake path string.
    return const Success<String>('export/settings_config.json');
  }

  @override
  Future<Result<void>> resetToDefaults() async {
    _config = ConsumerSettingsRepository().currentConfig;
    notifyListeners();
    return const Success(null);
  }

  @override
  Future<Result<void>> updateAccentColorKey(String accentColorKey) async {
    _config = SettingsConfig(
      theme: _config.theme.copyWith(accentColorKey: accentColorKey),
      accessibility: _config.accessibility,
      localization: _config.localization,
      brand: _config.brand,
      features: _config.features,
    );
    notifyListeners();
    return const Success(null);
  }

  @override
  bool isFeatureEnabled(String featureName) {
    if (featureName.toLowerCase() == 'data_export') {
      return _config.features.enableDataExport;
    }
    return false;
  }
}
