import '../../../../core/core.dart';
import '../../domain/value_objects/theme_mode_vo.dart';
import '../../domain/value_objects/text_scale.dart';
import '../../domain/value_objects/language_code.dart';
import '../../domain/repositories/settings_repository.dart';

class UpdateThemeMode implements UseCase<void, ThemeModeVO> {
  final SettingsRepository repo;
  UpdateThemeMode(this.repo);
  @override
  Future<Result<void>> call(ThemeModeVO params) => repo.updateThemeMode(params);
}

class UpdateTextScale implements UseCase<void, TextScale> {
  final SettingsRepository repo;
  UpdateTextScale(this.repo);
  @override
  Future<Result<void>> call(TextScale params) => repo.updateTextScaleFactor(params);
}

class UpdateReduceAnimations implements UseCase<void, bool> {
  final SettingsRepository repo;
  UpdateReduceAnimations(this.repo);
  @override
  Future<Result<void>> call(bool params) => repo.updateReduceAnimations(params);
}

class UpdateHighContrast implements UseCase<void, bool> {
  final SettingsRepository repo;
  UpdateHighContrast(this.repo);
  @override
  Future<Result<void>> call(bool params) => repo.updateHighContrast(params);
}

class UpdateLargerTouchTargets implements UseCase<void, bool> {
  final SettingsRepository repo;
  UpdateLargerTouchTargets(this.repo);
  @override
  Future<Result<void>> call(bool params) => repo.updateLargerTouchTargets(params);
}

class UpdateVoiceGuidance implements UseCase<void, bool> {
  final SettingsRepository repo;
  UpdateVoiceGuidance(this.repo);
  @override
  Future<Result<void>> call(bool params) => repo.updateVoiceGuidance(params);
}

class UpdateHapticFeedback implements UseCase<void, bool> {
  final SettingsRepository repo;
  UpdateHapticFeedback(this.repo);
  @override
  Future<Result<void>> call(bool params) => repo.updateHapticFeedback(params);
}

class UpdateUseDeviceLocale implements UseCase<void, bool> {
  final SettingsRepository repo;
  UpdateUseDeviceLocale(this.repo);
  @override
  Future<Result<void>> call(bool params) => repo.updateUseDeviceLocale(params);
}

class UpdateLanguageCode implements UseCase<void, LanguageCode> {
  final SettingsRepository repo;
  UpdateLanguageCode(this.repo);
  @override
  Future<Result<void>> call(LanguageCode params) => repo.updateLanguageCode(params);
}

class ExportConfiguration implements UseCase<String, NoParams> {
  final SettingsRepository repo;
  ExportConfiguration(this.repo);
  @override
  Future<Result<String>> call(NoParams params) => repo.exportConfiguration();
}

class ResetToDefaults implements UseCase<void, NoParams> {
  final SettingsRepository repo;
  ResetToDefaults(this.repo);
  @override
  Future<Result<void>> call(NoParams params) => repo.resetToDefaults();
}
