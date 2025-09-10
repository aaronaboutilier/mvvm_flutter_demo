// lib/viewmodels/settings_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/config_service.dart';
import '../models/app_config.dart';

/// SettingsViewModel manages the business logic for user preference changes
/// This demonstrates how configuration management integrates with MVVM patterns.
/// 
/// Notice how this ViewModel focuses purely on business logic - it doesn't
/// know anything about UI components, but it provides a clean interface
/// for the View to interact with configuration settings.
class SettingsViewModel extends ChangeNotifier {
  final ConfigService _configService = ConfigService.instance;
  
  // State for tracking ongoing operations
  bool _isUpdating = false;
  String? _errorMessage;
  String? _successMessage;

  // Public getters for View to access state
  bool get isUpdating => _isUpdating;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  
  // Quick access to current configuration
  AppConfig get currentConfig => _configService.currentConfig;

  /// Updates the theme mode preference
  /// This method demonstrates how ViewModels handle user preference changes
  /// while providing appropriate feedback and error handling
  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    await _performConfigUpdate(
      'Updating theme mode',
      () async {
        final updatedTheme = currentConfig.theme.copyWith(
          themeMode: newThemeMode,
        );
        await _configService.updateThemeConfig(updatedTheme);
        
        // Provide haptic feedback if enabled
        if (currentConfig.accessibility.enableHapticFeedback) {
          HapticFeedback.selectionClick();
        }
      },
    );
  }

  /// Updates text scale factor for accessibility
  /// This shows how accessibility preferences are managed through the ViewModel
  Future<void> updateTextScaleFactor(double newScaleFactor) async {
    await _performConfigUpdate(
      'Updating text size',
      () async {
        final updatedTheme = currentConfig.theme.copyWith(
          textScaleFactor: newScaleFactor,
        );
        await _configService.updateThemeConfig(updatedTheme);
        
        // Provide feedback for accessibility
        if (currentConfig.accessibility.enableHapticFeedback) {
          HapticFeedback.lightImpact();
        }
      },
    );
  }

  /// Updates reduce animations accessibility setting
  /// This demonstrates how accessibility preferences flow through the MVVM system
  Future<void> updateReduceAnimations(bool reduceAnimations) async {
    await _performConfigUpdate(
      'Updating animation preferences',
      () async {
        final updatedAccessibility = currentConfig.accessibility.copyWith(
          reduceAnimations: reduceAnimations,
        );
        await _configService.updateAccessibilityConfig(updatedAccessibility);
        
        // Only provide haptic feedback if the user hasn't disabled animations
        // This shows how settings can influence each other logically
        if (currentConfig.accessibility.enableHapticFeedback && !reduceAnimations) {
          HapticFeedback.selectionClick();
        }
      },
    );
  }

  /// Updates high contrast accessibility setting
  Future<void> updateHighContrast(bool highContrast) async {
    await _performConfigUpdate(
      'Updating contrast settings',
      () async {
        final updatedAccessibility = currentConfig.accessibility.copyWith(
          increasedContrast: highContrast,
        );
        await _configService.updateAccessibilityConfig(updatedAccessibility);
        
        if (currentConfig.accessibility.enableHapticFeedback) {
          HapticFeedback.selectionClick();
        }
      },
    );
  }

  /// Updates larger touch targets accessibility setting
  Future<void> updateLargerTouchTargets(bool largerTouchTargets) async {
    await _performConfigUpdate(
      'Updating touch target size',
      () async {
        final updatedAccessibility = currentConfig.accessibility.copyWith(
          largerTouchTargets: largerTouchTargets,
        );
        await _configService.updateAccessibilityConfig(updatedAccessibility);
        
        if (currentConfig.accessibility.enableHapticFeedback) {
          HapticFeedback.selectionClick();
        }
      },
    );
  }

  /// Updates voice guidance accessibility setting
  Future<void> updateVoiceGuidance(bool enableVoiceGuidance) async {
    await _performConfigUpdate(
      'Updating voice guidance',
      () async {
        final updatedAccessibility = currentConfig.accessibility.copyWith(
          enableVoiceGuidance: enableVoiceGuidance,
        );
        await _configService.updateAccessibilityConfig(updatedAccessibility);
        
        if (currentConfig.accessibility.enableHapticFeedback) {
          HapticFeedback.selectionClick();
        }
      },
    );
  }

  /// Updates haptic feedback accessibility setting
  Future<void> updateHapticFeedback(bool enableHapticFeedback) async {
    await _performConfigUpdate(
      'Updating haptic feedback',
      () async {
        final updatedAccessibility = currentConfig.accessibility.copyWith(
          enableHapticFeedback: enableHapticFeedback,
        );
        await _configService.updateAccessibilityConfig(updatedAccessibility);
        
        // Provide one last haptic feedback before potentially disabling it
        if (enableHapticFeedback) {
          HapticFeedback.selectionClick();
        }
      },
    );
  }

  /// Updates device locale usage preference
  /// This shows how localization preferences are managed
  Future<void> updateUseDeviceLocale(bool useDeviceLocale) async {
    await _performConfigUpdate(
      'Updating language preferences',
      () async {
        final updatedLocalization = currentConfig.localization.copyWith(
          useDeviceLocale: useDeviceLocale,
        );
        await _configService.updateLocalizationConfig(updatedLocalization);
        
        if (currentConfig.accessibility.enableHapticFeedback) {
          HapticFeedback.selectionClick();
        }
      },
    );
  }

  /// Updates the specific language code
  /// This demonstrates how manual language selection works
  Future<void> updateLanguageCode(String languageCode) async {
    await _performConfigUpdate(
      'Updating language',
      () async {
        final updatedLocalization = currentConfig.localization.copyWith(
          languageCode: languageCode,
          useDeviceLocale: false, // Automatically disable device locale when manually selecting
        );
        await _configService.updateLocalizationConfig(updatedLocalization);
        
        if (currentConfig.accessibility.enableHapticFeedback) {
          HapticFeedback.selectionClick();
        }
      },
    );
  }

  /// Exports the current configuration to a file
  /// This demonstrates how feature flags can control advanced functionality
  Future<void> exportConfiguration() async {
    if (!currentConfig.features.enableDataExport) {
      _setError('Export functionality is not available in this version');
      return;
    }

    await _performConfigUpdate(
      'Exporting configuration',
      () async {
        final file = await _configService.exportConfiguration();
        if (file != null) {
          _setSuccess('Configuration exported to: ${file.path}');
        } else {
          throw Exception('Failed to export configuration');
        }
      },
    );
  }

  /// Resets all settings to defaults
  /// This shows how to handle potentially destructive operations
  Future<void> resetToDefaults() async {
    await _performConfigUpdate(
      'Resetting to defaults',
      () async {
        await _configService.resetToDefaults();
        _setSuccess('Settings reset to defaults');
        
        // Provide strong haptic feedback for important actions
        HapticFeedback.heavyImpact();
      },
    );
  }

  /// Generic method for performing configuration updates with consistent error handling
  /// This pattern ensures all configuration changes follow the same flow:
  /// 1. Set loading state
  /// 2. Clear previous messages
  /// 3. Perform the operation
  /// 4. Handle success/error appropriately
  /// 5. Clear loading state
  /// 6. Notify listeners
  Future<void> _performConfigUpdate(String operation, Future<void> Function() updateFunction) async {
    _setLoading(true);
    _clearMessages();

    try {
      debugPrint('Starting: $operation');
      
      await updateFunction();
      
      debugPrint('Completed: $operation');
      
      // Most updates don't need explicit success messages since the UI will reflect changes
      // Only set success messages for operations that aren't immediately visible
      
    } catch (error) {
      debugPrint('Error during $operation: $error');
      _setError('Failed to update settings: ${error.toString()}');
      
      // Provide error haptic feedback if available
      if (currentConfig.accessibility.enableHapticFeedback) {
        HapticFeedback.heavyImpact();
      }
    } finally {
      _setLoading(false);
    }
  }

  /// Sets loading state and notifies listeners
  void _setLoading(bool loading) {
    _isUpdating = loading;
    notifyListeners();
  }

  /// Sets error message and notifies listeners
  void _setError(String error) {
    _errorMessage = error;
    _successMessage = null;
    notifyListeners();
    
    // Clear error message after a delay
    Future.delayed(const Duration(seconds: 5), () {
      if (_errorMessage == error) {
        _clearMessages();
      }
    });
  }

  /// Sets success message and notifies listeners
  void _setSuccess(String message) {
    _successMessage = message;
    _errorMessage = null;
    notifyListeners();
    
    // Clear success message after a delay
    Future.delayed(const Duration(seconds: 3), () {
      if (_successMessage == message) {
        _clearMessages();
      }
    });
  }

  /// Clears all messages
  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  /// Checks if a specific feature is enabled
  /// This provides a convenient way for the View to check feature availability
  bool isFeatureEnabled(String featureName) {
    return _configService.isFeatureEnabled(featureName);
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