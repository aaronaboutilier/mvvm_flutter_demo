import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../domain/repositories/settings_repository.dart';

class UpdateThemeMode implements UseCase<void, ThemeMode> {
  final SettingsRepository repo;
  UpdateThemeMode(this.repo);
  @override
  Future<Result<void>> call(ThemeMode params) => repo.updateThemeMode(params);
}

class UpdateTextScale implements UseCase<void, double> {
  final SettingsRepository repo;
  UpdateTextScale(this.repo);
  @override
  Future<Result<void>> call(double params) => repo.updateTextScaleFactor(params);
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

class UpdateLanguageCode implements UseCase<void, String> {
  final SettingsRepository repo;
  UpdateLanguageCode(this.repo);
  @override
  Future<Result<void>> call(String params) => repo.updateLanguageCode(params);
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
