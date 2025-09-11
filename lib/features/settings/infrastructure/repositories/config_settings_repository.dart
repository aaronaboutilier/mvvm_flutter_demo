import '../../../../core/core.dart';
import '../../../../core/configuration/configuration.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/value_objects/language_code.dart';
import '../../domain/value_objects/text_scale.dart';
import '../../domain/value_objects/theme_preference.dart';
import 'package:flutter/material.dart' show ThemeMode;

class ConfigSettingsRepository implements SettingsRepository {
  final ConfigService _service;
  ConfigSettingsRepository([ConfigService? service]) : _service = service ?? ConfigService.instance;

  @override
  AppConfig get currentConfig => _service.currentConfig;

  @override
  bool isFeatureEnabled(String featureName) => _service.isFeatureEnabled(featureName);

  @override
  Future<Result<void>> updateThemeMode(ThemePreference newThemeMode) async {
    try {
      final themeMode = switch (newThemeMode) {
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
        ThemePreference.system => ThemeMode.system,
      };
      final updated = currentConfig.theme.copyWith(themeMode: themeMode);
      await _service.updateThemeConfig(updated);
      return const Success(null);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> updateTextScaleFactor(TextScale newScaleFactor) async {
    try {
      final updated = currentConfig.theme.copyWith(textScaleFactor: newScaleFactor.value);
      await _service.updateThemeConfig(updated);
      return const Success(null);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> updateReduceAnimations(bool reduceAnimations) async {
    try {
      final updated = currentConfig.accessibility.copyWith(reduceAnimations: reduceAnimations);
      await _service.updateAccessibilityConfig(updated);
      return const Success(null);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> updateHighContrast(bool highContrast) async {
    try {
      final updated = currentConfig.accessibility.copyWith(increasedContrast: highContrast);
      await _service.updateAccessibilityConfig(updated);
      return const Success(null);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> updateLargerTouchTargets(bool largerTouchTargets) async {
    try {
      final updated = currentConfig.accessibility.copyWith(largerTouchTargets: largerTouchTargets);
      await _service.updateAccessibilityConfig(updated);
      return const Success(null);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> updateVoiceGuidance(bool enableVoiceGuidance) async {
    try {
      final updated = currentConfig.accessibility.copyWith(enableVoiceGuidance: enableVoiceGuidance);
      await _service.updateAccessibilityConfig(updated);
      return const Success(null);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> updateHapticFeedback(bool enableHapticFeedback) async {
    try {
      final updated = currentConfig.accessibility.copyWith(enableHapticFeedback: enableHapticFeedback);
      await _service.updateAccessibilityConfig(updated);
      return const Success(null);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> updateUseDeviceLocale(bool useDeviceLocale) async {
    try {
      final updated = currentConfig.localization.copyWith(useDeviceLocale: useDeviceLocale);
      await _service.updateLocalizationConfig(updated);
      return const Success(null);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> updateLanguageCode(LanguageCode languageCode) async {
    try {
      final updated = currentConfig.localization.copyWith(
        languageCode: languageCode.value,
        useDeviceLocale: false,
      );
      await _service.updateLocalizationConfig(updated);
      return const Success(null);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<String>> exportConfiguration() async {
    try {
      final file = await _service.exportConfiguration();
      if (file == null) {
        return const FailureResult(ConfigFailure(message: 'Failed to export configuration'));
      }
      return Success(file.path);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }

  @override
  Future<Result<void>> resetToDefaults() async {
    try {
      await _service.resetToDefaults();
      return const Success(null);
    } catch (e, s) {
      return FailureResult(ErrorMapper.map(e, s));
    }
  }
}
