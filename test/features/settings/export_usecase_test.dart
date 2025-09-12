import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_foundation/core/core.dart' as foundation;
import 'package:feature_settings/feature_settings.dart';

class _Repo implements SettingsRepository {
  bool failExport = false;

  @override
  SettingsConfig get currentConfig => const SettingsConfig(
        theme: ThemeSettings(themeMode: ThemeMode.system, textScaleFactor: 1.0),
        accessibility: AccessibilitySettings(
          reduceAnimations: false,
          increasedContrast: false,
          largerTouchTargets: false,
          enableVoiceGuidance: false,
          enableHapticFeedback: true,
        ),
        localization: LocalizationSettings(useDeviceLocale: true, languageCode: 'en'),
        brand: BrandInfo(appName: 'Test', websiteUrl: 'https://example.com', supportEmail: 'support@example.com'),
        features: FeatureSettings(enableDataExport: true),
      );

  @override
  bool isFeatureEnabled(String featureName) => true;

  @override
  Future<foundation.Result<String>> exportConfiguration() async {
    if (failExport) return const foundation.FailureResult(foundation.Failure(message: 'x', code: 'config'));
    return const foundation.Success('/tmp/out.json');
  }

  @override
  Future<foundation.Result<void>> resetToDefaults() async => const foundation.Success(null);

  @override
  Future<foundation.Result<void>> updateHighContrast(bool highContrast) async => const foundation.Success(null);

  @override
  Future<foundation.Result<void>> updateHapticFeedback(bool enableHapticFeedback) async => const foundation.Success(null);

  @override
  Future<foundation.Result<void>> updateLanguageCode(LanguageCode languageCode) async => const foundation.Success(null);

  @override
  Future<foundation.Result<void>> updateLargerTouchTargets(bool largerTouchTargets) async => const foundation.Success(null);

  @override
  Future<foundation.Result<void>> updateReduceAnimations(bool reduceAnimations) async => const foundation.Success(null);

  @override
  Future<foundation.Result<void>> updateTextScaleFactor(TextScale newScaleFactor) async => const foundation.Success(null);

  @override
  Future<foundation.Result<void>> updateThemeMode(ThemePreference newThemeMode) async => const foundation.Success(null);

  @override
  Future<foundation.Result<void>> updateUseDeviceLocale(bool useDeviceLocale) async => const foundation.Success(null);

  @override
  Future<foundation.Result<void>> updateVoiceGuidance(bool enableVoiceGuidance) async => const foundation.Success(null);
}

void main() {
  test('ExportConfiguration returns success path', () async {
    final repo = _Repo();
    final uc = ExportConfiguration(repo);
    final res = await uc(const foundation.NoParams());
    expect(res, isA<foundation.Success<String>>());
  });

  test('ExportConfiguration returns failure path', () async {
    final repo = _Repo()..failExport = true;
    final uc = ExportConfiguration(repo);
    final res = await uc(const foundation.NoParams());
    expect(res, isA<foundation.FailureResult<String>>());
  });
}
