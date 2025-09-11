// lib/viewmodels/settings_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/core.dart' as core;
import '../models/app_config.dart';
import '../features/settings/application/usecases/settings_usecases.dart';
import '../features/settings/domain/value_objects/text_scale.dart' as vo;
import '../features/settings/domain/value_objects/language_code.dart' as vo;
import '../features/settings/domain/value_objects/theme_preference.dart' as vo;
import '../features/settings/domain/repositories/settings_repository.dart';
import '../core/presentation/base_view_model.dart';

/// SettingsViewModel manages the business logic for user preference changes
/// This demonstrates how configuration management integrates with MVVM patterns.
/// 
/// Notice how this ViewModel focuses purely on business logic - it doesn't
/// know anything about UI components, but it provides a clean interface
/// for the View to interact with configuration settings.
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
  
  // Backwards compatibility getters for previous API
  bool get isUpdating => isLoading;
  // errorMessage and successMessage come from BaseViewModel
  
  // Quick access to current configuration
  AppConfig get currentConfig => _repo.currentConfig;

  /// Updates the theme mode preference
  /// This method demonstrates how ViewModels handle user preference changes
  /// while providing appropriate feedback and error handling
  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
  await performOperation(
      'Updating theme mode',
      () async {
        final pref = switch (newThemeMode) {
          ThemeMode.light => vo.ThemePreference.light,
          ThemeMode.dark => vo.ThemePreference.dark,
          ThemeMode.system => vo.ThemePreference.system,
        };
        await _updateThemeMode(pref);
        
        // Provide haptic feedback if enabled
  _maybeHapticSelection();
  },
    );
  }

  /// Updates text scale factor for accessibility
  /// This shows how accessibility preferences are managed through the ViewModel
  Future<void> updateTextScaleFactor(double newScaleFactor) async {
  await performOperation(
      'Updating text size',
      () async {
  await _updateTextScale(vo.TextScale(newScaleFactor));
        
  _maybeHapticLight();
      },
    );
  }

  /// Updates reduce animations accessibility setting
  /// This demonstrates how accessibility preferences flow through the MVVM system
  Future<void> updateReduceAnimations(bool reduceAnimations) async {
  await performOperation(
      'Updating animation preferences',
      () async {
  await _updateReduceAnimations(reduceAnimations);
        
        // Only provide haptic feedback if the user hasn't disabled animations
        // This shows how settings can influence each other logically
  if (!reduceAnimations) _maybeHapticSelection();
      },
    );
  }

  /// Updates high contrast accessibility setting
  Future<void> updateHighContrast(bool highContrast) async {
  await performOperation(
      'Updating contrast settings',
      () async {
  await _updateHighContrast(highContrast);
        
  _maybeHapticSelection();
      },
    );
  }

  /// Updates larger touch targets accessibility setting
  Future<void> updateLargerTouchTargets(bool largerTouchTargets) async {
  await performOperation(
      'Updating touch target size',
      () async {
  await _updateLargerTouchTargets(largerTouchTargets);
        
  _maybeHapticSelection();
      },
    );
  }

  /// Updates voice guidance accessibility setting
  Future<void> updateVoiceGuidance(bool enableVoiceGuidance) async {
  await performOperation(
      'Updating voice guidance',
      () async {
  await _updateVoiceGuidance(enableVoiceGuidance);
        
  _maybeHapticSelection();
      },
    );
  }

  /// Updates haptic feedback accessibility setting
  Future<void> updateHapticFeedback(bool enableHapticFeedback) async {
  await performOperation(
      'Updating haptic feedback',
      () async {
  await _updateHapticFeedback(enableHapticFeedback);
        
        // Provide one last haptic feedback before potentially disabling it
  if (enableHapticFeedback) _maybeHapticSelection();
      },
    );
  }

  /// Updates device locale usage preference
  /// This shows how localization preferences are managed
  Future<void> updateUseDeviceLocale(bool useDeviceLocale) async {
  await performOperation(
      'Updating language preferences',
      () async {
  await _updateUseDeviceLocale(useDeviceLocale);
        
  _maybeHapticSelection();
      },
    );
  }

  /// Updates the specific language code
  /// This demonstrates how manual language selection works
  Future<void> updateLanguageCode(String languageCode) async {
  await performOperation(
      'Updating language',
      () async {
        final res = await _updateLanguageCode(vo.LanguageCode(languageCode));
        res.fold(
          failure: (f) => throw Exception(f.message),
          success: (_) {},
        );
  _maybeHapticSelection();
      },
    );
  }

  /// Exports the current configuration to a file
  /// This demonstrates how feature flags can control advanced functionality
  Future<void> exportConfiguration() async {
    if (!currentConfig.features.enableDataExport) {
      setError('Export functionality is not available in this version');
      return;
    }

  await performOperation(
      'Exporting configuration',
      () async {
        final res = await _exportConfiguration(const core.NoParams());
        res.fold(
          failure: (f) => throw Exception(f.message),
      success: (path) => setSuccess('Configuration exported to: $path'),
        );
      },
    );
  }

  /// Resets all settings to defaults
  /// This shows how to handle potentially destructive operations
  Future<void> resetToDefaults() async {
  await performOperation(
      'Resetting to defaults',
      () async {
  await _resetToDefaults(const core.NoParams());
    setSuccess('Settings reset to defaults');
        
        _maybeHapticHeavy();
      },
    );
  }

  // Small helpers to reduce repetition when triggering haptics
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

  /// Checks if a specific feature is enabled
  /// This provides a convenient way for the View to check feature availability
  bool isFeatureEnabled(String featureName) {
  return _repo.isFeatureEnabled(featureName);
  }

  /// Gets a user-friendly description of current accessibility settings
  /// This demonstrates how ViewModels can provide computed properties for the UI
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

  /// Gets a summary of current theme settings
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

  @override
  void dispose() {
    // Clean up any ongoing operations
    super.dispose();
  }
}