import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/core.dart' as core;
import '../../../../models/app_config.dart';
import '../../application/usecases/settings_usecases.dart';
import '../../domain/value_objects/text_scale.dart' as vo;
import '../../domain/value_objects/language_code.dart' as vo;
import '../../domain/value_objects/theme_preference.dart' as vo;
import '../../domain/repositories/settings_repository.dart';
import '../../../../core/core.dart';

class SettingsViewModel extends BaseViewModel {
  final SettingsRepository _repo;
  late final UpdateThemeMode _updateThemeMode;
  late final UpdateTextScale _updateTextScale;
  late final UpdateReduceAnimations _updateReduceAnimations;
  late final UpdateHighContrast _updateHighContrast;
  late final UpdateLargerTouchTargets _updateLargerTouchTargets;
  late final UpdateVoiceGuidance _updateVoiceGuidance;
  late final UpdateHapticFeedback _updateHapticFeedback;
  late final UpdateUseDeviceLocale _updateUseDeviceLocale;
  late final UpdateLanguageCode _updateLanguageCode;
  late final ExportConfiguration _exportConfiguration;
  late final ResetToDefaults _resetToDefaults;

  SettingsViewModel({
    required SettingsRepository repo,
    required UpdateThemeMode updateThemeMode,
    required UpdateTextScale updateTextScale,
    required UpdateReduceAnimations updateReduceAnimations,
    required UpdateHighContrast updateHighContrast,
    required UpdateLargerTouchTargets updateLargerTouchTargets,
    required UpdateVoiceGuidance updateVoiceGuidance,
    required UpdateHapticFeedback updateHapticFeedback,
    required UpdateUseDeviceLocale updateUseDeviceLocale,
    required UpdateLanguageCode updateLanguageCode,
    required ExportConfiguration exportConfiguration,
    required ResetToDefaults resetToDefaults,
  })  : _repo = repo,
        _updateThemeMode = updateThemeMode,
        _updateTextScale = updateTextScale,
        _updateReduceAnimations = updateReduceAnimations,
        _updateHighContrast = updateHighContrast,
        _updateLargerTouchTargets = updateLargerTouchTargets,
        _updateVoiceGuidance = updateVoiceGuidance,
        _updateHapticFeedback = updateHapticFeedback,
        _updateUseDeviceLocale = updateUseDeviceLocale,
        _updateLanguageCode = updateLanguageCode,
        _exportConfiguration = exportConfiguration,
        _resetToDefaults = resetToDefaults;

  bool get isUpdating => isLoading;
  AppConfig get currentConfig => _repo.currentConfig;

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    await performOperation('Updating theme mode', () async {
      final pref = switch (newThemeMode) {
        ThemeMode.light => vo.ThemePreference.light,
        ThemeMode.dark => vo.ThemePreference.dark,
        ThemeMode.system => vo.ThemePreference.system,
      };
      await _updateThemeMode(pref);
      _maybeHapticSelection();
    });
  }

  Future<void> updateTextScaleFactor(double newScaleFactor) async {
    await performOperation('Updating text size', () async {
      await _updateTextScale(vo.TextScale(newScaleFactor));
      _maybeHapticLight();
    });
  }

  Future<void> updateReduceAnimations(bool reduceAnimations) async {
    await performOperation('Updating animation preferences', () async {
      await _updateReduceAnimations(reduceAnimations);
      if (!reduceAnimations) _maybeHapticSelection();
    });
  }

  Future<void> updateHighContrast(bool highContrast) async {
    await performOperation('Updating contrast settings', () async {
      await _updateHighContrast(highContrast);
      _maybeHapticSelection();
    });
  }

  Future<void> updateLargerTouchTargets(bool largerTouchTargets) async {
    await performOperation('Updating touch target size', () async {
      await _updateLargerTouchTargets(largerTouchTargets);
      _maybeHapticSelection();
    });
  }

  Future<void> updateVoiceGuidance(bool enableVoiceGuidance) async {
    await performOperation('Updating voice guidance', () async {
      await _updateVoiceGuidance(enableVoiceGuidance);
      _maybeHapticSelection();
    });
  }

  Future<void> updateHapticFeedback(bool enableHapticFeedback) async {
    await performOperation('Updating haptic feedback', () async {
      await _updateHapticFeedback(enableHapticFeedback);
      if (enableHapticFeedback) _maybeHapticSelection();
    });
  }

  Future<void> updateUseDeviceLocale(bool useDeviceLocale) async {
    await performOperation('Updating language preferences', () async {
      await _updateUseDeviceLocale(useDeviceLocale);
      _maybeHapticSelection();
    });
  }

  Future<void> updateLanguageCode(String languageCode) async {
    await performOperation('Updating language', () async {
      final res = await _updateLanguageCode(vo.LanguageCode(languageCode));
      res.fold(
        failure: (f) => throw Exception(f.message),
        success: (_) {},
      );
      _maybeHapticSelection();
    });
  }

  Future<void> exportConfiguration() async {
    if (!currentConfig.features.enableDataExport) {
      setError('Export functionality is not available in this version');
      return;
    }
    await performOperation('Exporting configuration', () async {
      final res = await _exportConfiguration(const core.NoParams());
      res.fold(
        failure: (f) => throw Exception(f.message),
        success: (path) => setSuccess('Configuration exported to: $path'),
      );
    });
  }

  Future<void> resetToDefaults() async {
    await performOperation('Resetting to defaults', () async {
      await _resetToDefaults(const core.NoParams());
      setSuccess('Settings reset to defaults');
      _maybeHapticHeavy();
    });
  }

  bool isFeatureEnabled(String featureName) => _repo.isFeatureEnabled(featureName);

  String getAccessibilityStatusSummary() {
    final accessibility = currentConfig.accessibility;
    List<String> activeFeatures = [];
    if (accessibility.reduceAnimations) activeFeatures.add('Reduced motion');
    if (accessibility.increasedContrast) activeFeatures.add('High contrast');
    if (accessibility.largerTouchTargets) activeFeatures.add('Large touch targets');
    if (accessibility.enableVoiceGuidance) activeFeatures.add('Voice guidance');
    if (!accessibility.enableHapticFeedback) activeFeatures.add('Haptics disabled');
    if (activeFeatures.isEmpty) {
      return 'Standard accessibility settings';
    } else {
      return 'Active: ${activeFeatures.join(', ')}';
    }
  }

  String getThemeStatusSummary() {
    final theme = currentConfig.theme;
    final themeName = switch (theme.themeMode) {
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
      ThemeMode.system => 'System',
    };
    String summary = themeName;
    if (theme.textScaleFactor != 1.0) {
      summary += ', ${(theme.textScaleFactor * 100).round()}% text size';
    }
    return summary;
  }

  void _maybeHapticSelection() {
    if (currentConfig.accessibility.enableHapticFeedback) {
      HapticFeedback.selectionClick();
    }
  }

  void _maybeHapticLight() {
    if (currentConfig.accessibility.enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }
  }

  void _maybeHapticHeavy() {
    if (currentConfig.accessibility.enableHapticFeedback) {
      HapticFeedback.heavyImpact();
    }
  }
}
