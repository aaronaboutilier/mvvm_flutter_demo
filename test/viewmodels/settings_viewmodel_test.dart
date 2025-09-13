import 'package:core_foundation/core/core.dart' as foundation;
import 'package:feature_settings/feature_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSettingsRepo implements SettingsRepository {
  SettingsConfig _config = const SettingsConfig(
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
      appName: 'Test',
      websiteUrl: 'https://example.com',
      supportEmail: 'support@example.com',
    ),
    features: FeatureSettings(enableDataExport: true),
  );

  bool failLanguage = false;
  bool failExport = false;

  @override
  SettingsConfig get currentConfig => _config;

  @override
  bool isFeatureEnabled(String featureName) => true;

  @override
  Future<foundation.Result<String>> exportConfiguration() async {
    if (failExport) {
      return const foundation.FailureResult(
        foundation.Failure(message: 'export failed', code: 'config'),
      );
    }
    return const foundation.Success('test/path.json');
  }

  @override
  Future<foundation.Result<void>> resetToDefaults() async {
    _config = const SettingsConfig(
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
        appName: 'Test',
        websiteUrl: 'https://example.com',
        supportEmail: 'support@example.com',
      ),
      features: FeatureSettings(enableDataExport: true),
    );
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> updateHighContrast({
    required bool highContrast,
  }) async {
    _config = SettingsConfig(
      theme: _config.theme,
      accessibility: _config.accessibility.copyWith(
        increasedContrast: highContrast,
      ),
      localization: _config.localization,
      brand: _config.brand,
      features: _config.features,
    );
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> updateHapticFeedback({
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
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> updateVoiceGuidance({
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
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> updateLanguageCode(
    LanguageCode languageCode,
  ) async {
    if (failLanguage) {
      return const foundation.FailureResult(
        foundation.Failure(message: 'bad language', code: 'validation'),
      );
    }
    _config = SettingsConfig(
      theme: _config.theme,
      accessibility: _config.accessibility,
      localization: _config.localization.copyWith(
        languageCode: languageCode.value,
        useDeviceLocale: false,
      ),
      brand: _config.brand,
      features: _config.features,
    );
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> updateLargerTouchTargets({
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
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> updateReduceAnimations({
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
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> updateTextScaleFactor(
    TextScale newScaleFactor,
  ) async {
    _config = SettingsConfig(
      theme: _config.theme.copyWith(textScaleFactor: newScaleFactor.value),
      accessibility: _config.accessibility,
      localization: _config.localization,
      brand: _config.brand,
      features: _config.features,
    );
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> updateThemeMode(
    ThemePreference newThemeMode,
  ) async {
    // We don't need to map here for tests; just flip text to ensure flow works
    return const foundation.Success(null);
  }

  @override
  Future<foundation.Result<void>> updateUseDeviceLocale({
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
    return const foundation.Success(null);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SettingsViewModel', () {
    test('updateTextScaleFactor success updates config', () async {
      final repo = _FakeSettingsRepo();
      final vm = SettingsViewModel(
        repo: repo,
        updateThemeMode: UpdateThemeMode(repo),
        updateTextScale: UpdateTextScale(repo),
        updateReduceAnimations: UpdateReduceAnimations(repo),
        updateHighContrast: UpdateHighContrast(repo),
        updateLargerTouchTargets: UpdateLargerTouchTargets(repo),
        updateVoiceGuidance: UpdateVoiceGuidance(repo),
        updateHapticFeedback: UpdateHapticFeedback(repo),
        updateUseDeviceLocale: UpdateUseDeviceLocale(repo),
        updateLanguageCode: UpdateLanguageCode(repo),
        exportConfiguration: ExportConfiguration(repo),
        resetToDefaults: ResetToDefaults(repo),
      );

      await vm.updateTextScaleFactor(1.3);

      expect(repo.currentConfig.theme.textScaleFactor, 1.3);
      expect(vm.errorMessage, isNull);
      expect(vm.isUpdating, isFalse);
    });

    test('updateLanguageCode failure sets errorMessage', () async {
      final repo = _FakeSettingsRepo()..failLanguage = true;
      final vm = SettingsViewModel(
        repo: repo,
        updateThemeMode: UpdateThemeMode(repo),
        updateTextScale: UpdateTextScale(repo),
        updateReduceAnimations: UpdateReduceAnimations(repo),
        updateHighContrast: UpdateHighContrast(repo),
        updateLargerTouchTargets: UpdateLargerTouchTargets(repo),
        updateVoiceGuidance: UpdateVoiceGuidance(repo),
        updateHapticFeedback: UpdateHapticFeedback(repo),
        updateUseDeviceLocale: UpdateUseDeviceLocale(repo),
        updateLanguageCode: UpdateLanguageCode(repo),
        exportConfiguration: ExportConfiguration(repo),
        resetToDefaults: ResetToDefaults(repo),
      );

      // Avoid platform channel issues from haptics in tests (updated API)
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (_) async => null);

      await vm.updateLanguageCode('xx');

      expect(vm.errorMessage, isNotNull);
      expect(vm.isUpdating, isFalse);
    });
  });
}
