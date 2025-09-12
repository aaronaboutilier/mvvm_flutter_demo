import 'dart:io';

import 'package:core_foundation/core/core.dart';
import 'package:flutter/material.dart';
import 'package:feature_settings/feature_settings.dart' as feature_settings;

import '../../../../core/configuration/app_config.dart';
import '../../../../core/configuration/config_service.dart';

class ConfigSettingsRepositoryAdapter implements feature_settings.SettingsRepository {
  final ConfigService _config;

  ConfigSettingsRepositoryAdapter(this._config);

  @override
  feature_settings.SettingsConfig get currentConfig => _mapAppConfig(_config.currentConfig);

  @override
  Future<Result<void>> updateThemeMode(feature_settings.ThemePreference newThemeMode) async {
    try {
      final mode = _mapThemePreference(newThemeMode);
      final updated = _config.currentConfig.theme.copyWith(themeMode: mode);
      await _config.updateThemeConfig(updated);
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to update theme mode', cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<void>> updateTextScaleFactor(feature_settings.TextScale newScaleFactor) async {
    try {
      final updated = _config.currentConfig.theme.copyWith(textScaleFactor: newScaleFactor.value);
      await _config.updateThemeConfig(updated);
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to update text scale', cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<void>> updateReduceAnimations(bool reduceAnimations) async {
    try {
      final updated = _config.currentConfig.accessibility.copyWith(reduceAnimations: reduceAnimations);
      await _config.updateAccessibilityConfig(updated);
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to update reduce animations', cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<void>> updateHighContrast(bool highContrast) async {
    try {
      final updated = _config.currentConfig.accessibility.copyWith(increasedContrast: highContrast);
      await _config.updateAccessibilityConfig(updated);
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to update high contrast', cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<void>> updateLargerTouchTargets(bool largerTouchTargets) async {
    try {
      final updated = _config.currentConfig.accessibility.copyWith(largerTouchTargets: largerTouchTargets);
      await _config.updateAccessibilityConfig(updated);
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to update touch targets', cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<void>> updateVoiceGuidance(bool enableVoiceGuidance) async {
    try {
      final updated = _config.currentConfig.accessibility.copyWith(enableVoiceGuidance: enableVoiceGuidance);
      await _config.updateAccessibilityConfig(updated);
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to update voice guidance', cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<void>> updateHapticFeedback(bool enableHapticFeedback) async {
    try {
      final updated = _config.currentConfig.accessibility.copyWith(enableHapticFeedback: enableHapticFeedback);
      await _config.updateAccessibilityConfig(updated);
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to update haptic feedback', cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<void>> updateUseDeviceLocale(bool useDeviceLocale) async {
    try {
      final updated = _config.currentConfig.localization.copyWith(useDeviceLocale: useDeviceLocale);
      await _config.updateLocalizationConfig(updated);
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to update device locale', cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<void>> updateLanguageCode(feature_settings.LanguageCode languageCode) async {
    try {
      final updated = _config.currentConfig.localization.copyWith(languageCode: languageCode.value);
      await _config.updateLocalizationConfig(updated);
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to update language code', cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<String>> exportConfiguration() async {
    try {
      final File? f = await _config.exportConfiguration();
      if (f == null) {
        return FailureResult(UnknownFailure(message: 'Export failed'));
      }
      return Success(f.path);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to export configuration', cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<void>> resetToDefaults() async {
    try {
      await _config.resetToDefaults();
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(message: 'Failed to reset to defaults', cause: e, stackTrace: st));
    }
  }

  @override
  bool isFeatureEnabled(String featureName) => _config.isFeatureEnabled(featureName);

  // --- Mapping helpers ---
  feature_settings.SettingsConfig _mapAppConfig(AppConfig c) {
    return feature_settings.SettingsConfig(
      theme: feature_settings.ThemeSettings(
        themeMode: c.theme.themeMode,
        textScaleFactor: c.theme.textScaleFactor,
      ),
      accessibility: feature_settings.AccessibilitySettings(
        reduceAnimations: c.accessibility.reduceAnimations,
        increasedContrast: c.accessibility.increasedContrast,
        largerTouchTargets: c.accessibility.largerTouchTargets,
        enableVoiceGuidance: c.accessibility.enableVoiceGuidance,
        enableHapticFeedback: c.accessibility.enableHapticFeedback,
      ),
      localization: feature_settings.LocalizationSettings(
        useDeviceLocale: c.localization.useDeviceLocale,
        languageCode: c.localization.languageCode,
      ),
      brand: const feature_settings.BrandInfo(
        appName: 'MVVM Demo',
        websiteUrl: 'https://example.com',
        supportEmail: 'support@example.com',
      ),
      features: feature_settings.FeatureSettings(
        enableDataExport: c.features.enableDataExport,
      ),
    );
  }

  ThemeMode _mapThemePreference(feature_settings.ThemePreference pref) {
    switch (pref) {
      case feature_settings.ThemePreference.light:
        return ThemeMode.light;
      case feature_settings.ThemePreference.dark:
        return ThemeMode.dark;
      case feature_settings.ThemePreference.system:
        return ThemeMode.system;
    }
  }
}
