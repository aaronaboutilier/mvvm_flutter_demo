import 'package:core_analytics/core_analytics.dart';
import 'package:core_foundation/core/core.dart' as foundation;
import 'package:feature_settings/src/application/usecases/settings_usecases.dart';
import 'package:feature_settings/src/domain/entities/settings_config.dart';
import 'package:feature_settings/src/domain/repositories/settings_repository.dart';
import 'package:feature_settings/src/domain/value_objects/language_code.dart'
    as vo;
import 'package:feature_settings/src/domain/value_objects/text_scale.dart'
    as vo;
import 'package:feature_settings/src/domain/value_objects/theme_preference.dart'
    as vo;
import 'package:feature_settings/src/presentation/viewmodels/settings_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ViewModel for managing settings state and operations.
class SettingsViewModel
    extends foundation.ChangeNotifierViewModel<SettingsViewState> {
  /// Creates a SettingsViewModel.
  SettingsViewModel({
    required SettingsRepository repo,
    required UpdateThemeMode updateThemeMode,
    required UpdateTextScale updateTextScale,
    required UpdateAccentColorKey updateAccentColorKey,
    required UpdateReduceAnimations updateReduceAnimations,
    required UpdateHighContrast updateHighContrast,
    required UpdateLargerTouchTargets updateLargerTouchTargets,
    required UpdateVoiceGuidance updateVoiceGuidance,
    required UpdateHapticFeedback updateHapticFeedback,
    required UpdateUseDeviceLocale updateUseDeviceLocale,
    required UpdateLanguageCode updateLanguageCode,
    required ExportConfiguration exportConfiguration,
    required ResetToDefaults resetToDefaults,
  }) : _repo = repo,
       _updateThemeMode = updateThemeMode,
       _updateTextScale = updateTextScale,
       _updateAccentColorKey = updateAccentColorKey,
       _updateReduceAnimations = updateReduceAnimations,
       _updateHighContrast = updateHighContrast,
       _updateLargerTouchTargets = updateLargerTouchTargets,
       _updateVoiceGuidance = updateVoiceGuidance,
       _updateHapticFeedback = updateHapticFeedback,
       _updateUseDeviceLocale = updateUseDeviceLocale,
       _updateLanguageCode = updateLanguageCode,
       _exportConfiguration = exportConfiguration,
       _resetToDefaults = resetToDefaults,
       super(SettingsViewState.initial());
  final SettingsRepository _repo;
  late final UpdateThemeMode _updateThemeMode;
  late final UpdateTextScale _updateTextScale;
  late final UpdateAccentColorKey _updateAccentColorKey;
  late final UpdateReduceAnimations _updateReduceAnimations;
  late final UpdateHighContrast _updateHighContrast;
  late final UpdateLargerTouchTargets _updateLargerTouchTargets;
  late final UpdateVoiceGuidance _updateVoiceGuidance;
  late final UpdateHapticFeedback _updateHapticFeedback;
  late final UpdateUseDeviceLocale _updateUseDeviceLocale;
  late final UpdateLanguageCode _updateLanguageCode;
  late final ExportConfiguration _exportConfiguration;
  late final ResetToDefaults _resetToDefaults;

  /// Indicates if a settings update operation is in progress.
  bool get isUpdating => state.isLoading;

  /// Success message from the last operation, if any.
  String? get successMessage => state.successMessage;

  /// Error message from the last operation, if any.
  String? get errorMessage => state.errorMessage;

  ///  current settings configuration.
  SettingsConfig get currentConfig => _repo.currentConfig;

  /// Updates the app's theme mode.
  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    final run = Analytics.trackedAsyncAction(
      'settings_change_theme_mode',
      () async {
        updateState(state.clearMessages().copyWith(isLoading: true));
        try {
          final pref = switch (newThemeMode) {
            ThemeMode.light => vo.ThemePreference.light,
            ThemeMode.dark => vo.ThemePreference.dark,
            ThemeMode.system => vo.ThemePreference.system,
          };
          await _updateThemeMode(pref);
          _maybeHapticSelection();
        } finally {
          updateState(state.copyWith(isLoading: false));
        }
      },
      parameters: () => <String, Object?>{'to': newThemeMode.name},
    );
    await run();
  }

  /// Updates the text scale factor.
  Future<void> updateTextScaleFactor(double newScaleFactor) async {
    updateState(state.clearMessages().copyWith(isLoading: true));
    try {
      await _updateTextScale(vo.TextScale(newScaleFactor));
      _maybeHapticLight();
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  /// Updates whether animations are reduced.

  /// Updates whether animations are reduced.
  Future<void> setReduceAnimations({required bool enabled}) async {
    updateState(state.clearMessages().copyWith(isLoading: true));
    try {
      await _updateReduceAnimations(reduceAnimations: enabled);
      if (!enabled) _maybeHapticSelection();
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  /// Updates whether high contrast mode is enabled.

  /// Updates whether high contrast mode is enabled.
  Future<void> setHighContrast({required bool enabled}) async {
    updateState(state.clearMessages().copyWith(isLoading: true));
    try {
      await _updateHighContrast(highContrast: enabled);
      _maybeHapticSelection();
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  /// Updates whether larger touch targets are enabled.

  /// Updates whether larger touch targets are enabled.
  Future<void> setLargerTouchTargets({required bool enabled}) async {
    updateState(state.clearMessages().copyWith(isLoading: true));
    try {
      await _updateLargerTouchTargets(largerTouchTargets: enabled);
      _maybeHapticSelection();
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  /// Updates whether voice guidance is enabled.

  /// Updates whether voice guidance is enabled.
  Future<void> setVoiceGuidanceEnabled({required bool enabled}) async {
    updateState(state.clearMessages().copyWith(isLoading: true));
    try {
      await _updateVoiceGuidance(enableVoiceGuidance: enabled);
      _maybeHapticSelection();
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  /// Updates whether haptic feedback is enabled.

  /// Updates whether haptic feedback is enabled.
  Future<void> setHapticFeedbackEnabled({required bool enabled}) async {
    updateState(state.clearMessages().copyWith(isLoading: true));
    try {
      await _updateHapticFeedback(enableHapticFeedback: enabled);
      if (enabled) _maybeHapticSelection();
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  /// Updates whether to use the device's locale or a specific language code.

  /// Updates whether to use the device's locale or a specific language code.
  Future<void> setUseDeviceLocale({required bool useDeviceLocale}) async {
    updateState(state.clearMessages().copyWith(isLoading: true));
    try {
      await _updateUseDeviceLocale(useDeviceLocale: useDeviceLocale);
      _maybeHapticSelection();
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  /// Updates the app's language code.
  Future<void> updateLanguageCode(String languageCode) async {
    updateState(state.clearMessages().copyWith(isLoading: true));
    try {
      final res = await _updateLanguageCode(vo.LanguageCode(languageCode));
      res.fold(
        failure: (f) => updateState(state.copyWith(errorMessage: f.message)),
        success: (_) {},
      );
      _maybeHapticSelection();
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  /// Exports the current settings configuration.
  Future<void> exportConfiguration() async {
    if (!currentConfig.features.enableDataExport) {
      updateState(
        state.copyWith(
          errorMessage: 'Export functionality is not available in this version',
        ),
      );
      return;
    }
    final run = Analytics.trackedAsyncAction(
      'settings_export_configuration',
      () async {
        updateState(state.clearMessages().copyWith(isLoading: true));
        try {
          final res = await _exportConfiguration(const foundation.NoParams());
          res.fold(
            failure: (f) => throw Exception(f.message),
            success: (path) => updateState(
              state.copyWith(
                successMessage: 'Configuration exported to: $path',
              ),
            ),
          );
        } finally {
          updateState(state.copyWith(isLoading: false));
        }
      },
    );
    await run();
  }

  /// Resets all settings to their default values.
  Future<void> resetToDefaults() async {
    final run = Analytics.trackedAsyncAction(
      'settings_reset_to_defaults',
      () async {
        updateState(state.clearMessages().copyWith(isLoading: true));
        try {
          await _resetToDefaults(const foundation.NoParams());
          updateState(
            state.copyWith(successMessage: 'Settings reset to defaults'),
          );
          _maybeHapticHeavy();
        } finally {
          updateState(state.copyWith(isLoading: false));
        }
      },
    );
    await run();
  }

  /// Checks if a specific feature is enabled.
  bool isFeatureEnabled(String featureName) =>
      _repo.isFeatureEnabled(featureName);

  /// Generates a summary of the current accessibility settings.
  String getAccessibilityStatusSummary() {
    final accessibility = currentConfig.accessibility;
    final activeFeatures = <String>[];
    if (accessibility.reduceAnimations) activeFeatures.add('Reduced motion');
    if (accessibility.increasedContrast) activeFeatures.add('High contrast');
    if (accessibility.largerTouchTargets) {
      activeFeatures.add('Large touch targets');
    }
    if (accessibility.enableVoiceGuidance) activeFeatures.add('Voice guidance');
    if (!accessibility.enableHapticFeedback) {
      activeFeatures.add('Haptics disabled');
    }
    if (activeFeatures.isEmpty) {
      return 'Standard accessibility settings';
    } else {
      return 'Active: ${activeFeatures.join(', ')}';
    }
  }

  /// Generates a summary of the current theme settings.
  String getThemeStatusSummary() {
    final theme = currentConfig.theme;
    final themeName = switch (theme.themeMode) {
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
      ThemeMode.system => 'System',
    };
    var summary = themeName;
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

  /// Selects a brand accent color via token key mapping and persists via repo.
  Future<void> selectBrandAccentColor(Color color) async {
    updateState(state.clearMessages().copyWith(isLoading: true));
    try {
      // Map Color to token key (simple heuristic to our AppColors set).
      final key = _mapColorToTokenKey(color);
      await _updateAccentColorKey(key);
      final msg = 'Accent color set to ${key.toUpperCase()}';
      updateState(state.copyWith(successMessage: msg));
      _maybeHapticSelection();
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  String _mapColorToTokenKey(Color color) {
    // Simple match against known token colors; default to 'primary'.
    const primary = Color(0xFF3F51B5);
    const secondary = Color(0xFFFF9800);
    const success = Color(0xFF4CAF50);
    const danger = Color(0xFFF44336);
    if (color == primary) return 'primary';
    if (color == secondary) return 'secondary';
    if (color == success) return 'success';
    if (color == danger) return 'danger';
    return 'primary';
  }
}
