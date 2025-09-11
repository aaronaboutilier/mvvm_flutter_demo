import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_flutter_demo/core/errors/failures.dart';
import 'package:mvvm_flutter_demo/core/result/result.dart';
import 'package:mvvm_flutter_demo/features/settings/application/usecases/settings_usecases.dart';
import 'package:mvvm_flutter_demo/features/settings/domain/repositories/settings_repository.dart';
import 'package:mvvm_flutter_demo/features/settings/domain/value_objects/language_code.dart' as vo;
import 'package:mvvm_flutter_demo/features/settings/domain/value_objects/text_scale.dart' as vo;
import 'package:mvvm_flutter_demo/features/settings/domain/value_objects/theme_preference.dart' as vo;
import 'package:mvvm_flutter_demo/models/app_config.dart';
import 'package:mvvm_flutter_demo/features/settings/presentation/viewmodels/settings_viewmodel.dart';

class _FakeSettingsRepo implements SettingsRepository {
  AppConfig _config = AppConfig.defaultConfig();

  bool failLanguage = false;
  bool failExport = false;

  @override
  AppConfig get currentConfig => _config;

  @override
  bool isFeatureEnabled(String featureName) => true;

  @override
  Future<Result<String>> exportConfiguration() async {
    if (failExport) return const FailureResult(ConfigFailure(message: 'export failed'));
    return const Success('test/path.json');
  }

  @override
  Future<Result<void>> resetToDefaults() async {
    _config = AppConfig.defaultConfig();
    return const Success(null);
  }

  @override
  Future<Result<void>> updateHighContrast(bool highContrast) async {
    _config = _config.copyWith(accessibility: _config.accessibility.copyWith(increasedContrast: highContrast));
    return const Success(null);
  }

  @override
  Future<Result<void>> updateHapticFeedback(bool enableHapticFeedback) async {
    _config = _config.copyWith(accessibility: _config.accessibility.copyWith(enableHapticFeedback: enableHapticFeedback));
    return const Success(null);
  }

  @override
  Future<Result<void>> updateVoiceGuidance(bool enableVoiceGuidance) async {
    _config = _config.copyWith(accessibility: _config.accessibility.copyWith(enableVoiceGuidance: enableVoiceGuidance));
    return const Success(null);
  }

  @override
  Future<Result<void>> updateLanguageCode(vo.LanguageCode languageCode) async {
    if (failLanguage) return const FailureResult(ValidationFailure(message: 'bad language'));
    _config = _config.copyWith(localization: _config.localization.copyWith(languageCode: languageCode.value, useDeviceLocale: false));
    return const Success(null);
  }

  @override
  Future<Result<void>> updateLargerTouchTargets(bool largerTouchTargets) async {
    _config = _config.copyWith(accessibility: _config.accessibility.copyWith(largerTouchTargets: largerTouchTargets));
    return const Success(null);
  }

  @override
  Future<Result<void>> updateReduceAnimations(bool reduceAnimations) async {
    _config = _config.copyWith(accessibility: _config.accessibility.copyWith(reduceAnimations: reduceAnimations));
    return const Success(null);
  }

  @override
  Future<Result<void>> updateTextScaleFactor(vo.TextScale newScaleFactor) async {
    _config = _config.copyWith(theme: _config.theme.copyWith(textScaleFactor: newScaleFactor.value));
    return const Success(null);
  }

  @override
  Future<Result<void>> updateThemeMode(vo.ThemePreference newThemeMode) async {
    // We don't need to map here for tests; just flip text to ensure flow works
    return const Success(null);
  }

  @override
  Future<Result<void>> updateUseDeviceLocale(bool useDeviceLocale) async {
    _config = _config.copyWith(localization: _config.localization.copyWith(useDeviceLocale: useDeviceLocale));
    return const Success(null);
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
