import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_flutter_demo/core/errors/failures.dart';
import 'package:mvvm_flutter_demo/core/result/result.dart';
import 'package:mvvm_flutter_demo/features/settings/application/usecases/settings_usecases.dart';
import 'package:mvvm_flutter_demo/core/core.dart' as core;
import 'package:mvvm_flutter_demo/features/settings/domain/repositories/settings_repository.dart';
import 'package:mvvm_flutter_demo/models/app_config.dart';

class _Repo implements SettingsRepository {
  bool failExport = false;
  @override
  AppConfig get currentConfig => AppConfig.defaultConfig();
  @override
  bool isFeatureEnabled(String featureName) => true;
  @override
  Future<Result<String>> exportConfiguration() async {
    if (failExport) return const FailureResult(ConfigFailure(message: 'x'));
    return const Success('/tmp/out.json');
  }
  @override
  Future<Result<void>> resetToDefaults() async => const Success(null);
  @override
  Future<Result<void>> updateHighContrast(bool highContrast) async => const Success(null);
  @override
  Future<Result<void>> updateHapticFeedback(bool enableHapticFeedback) async => const Success(null);
  @override
  Future<Result<void>> updateLanguageCode(languageCode) async => const Success(null);
  @override
  Future<Result<void>> updateLargerTouchTargets(bool largerTouchTargets) async => const Success(null);
  @override
  Future<Result<void>> updateReduceAnimations(bool reduceAnimations) async => const Success(null);
  @override
  Future<Result<void>> updateTextScaleFactor(newScaleFactor) async => const Success(null);
  @override
  Future<Result<void>> updateThemeMode(newThemeMode) async => const Success(null);
  @override
  Future<Result<void>> updateUseDeviceLocale(bool useDeviceLocale) async => const Success(null);
  @override
  Future<Result<void>> updateVoiceGuidance(bool enableVoiceGuidance) async => const Success(null);
}

void main() {
  test('ExportConfiguration returns success path', () async {
    final repo = _Repo();
    final uc = ExportConfiguration(repo);
  final res = await uc(const core.NoParams());
    expect(res, isA<Success<String>>());
  });

  test('ExportConfiguration returns failure path', () async {
    final repo = _Repo()..failExport = true;
    final uc = ExportConfiguration(repo);
  final res = await uc(const core.NoParams());
    expect(res, isA<FailureResult<String>>());
  });
}
