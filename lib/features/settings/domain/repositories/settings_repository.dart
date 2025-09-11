import 'package:flutter/material.dart';
import '../../../../models/app_config.dart';
import '../../../../core/result/result.dart';

abstract class SettingsRepository {
  AppConfig get currentConfig;

  Future<Result<void>> updateThemeMode(ThemeMode newThemeMode);
  Future<Result<void>> updateTextScaleFactor(double newScaleFactor);

  Future<Result<void>> updateReduceAnimations(bool reduceAnimations);
  Future<Result<void>> updateHighContrast(bool highContrast);
  Future<Result<void>> updateLargerTouchTargets(bool largerTouchTargets);
  Future<Result<void>> updateVoiceGuidance(bool enableVoiceGuidance);
  Future<Result<void>> updateHapticFeedback(bool enableHapticFeedback);

  Future<Result<void>> updateUseDeviceLocale(bool useDeviceLocale);
  Future<Result<void>> updateLanguageCode(String languageCode);

  Future<Result<String>> exportConfiguration();
  Future<Result<void>> resetToDefaults();

  bool isFeatureEnabled(String featureName);
}
