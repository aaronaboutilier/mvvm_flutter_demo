// lib/services/config_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import '../models/app_config.dart';

/// ConfigService is the central service that manages all app configuration
/// in your MVVM architecture. This service provides a clean separation
/// between configuration management and business logic, making it easy
/// to support multiple brands, themes, and user preferences.
/// 
/// The service follows the reactive pattern, notifying listeners when
/// configuration changes occur. This integrates beautifully with your
/// MVVM ViewModels through the ChangeNotifier pattern.
class ConfigService extends ChangeNotifier {
  static ConfigService? _instance;
  
  /// Singleton pattern ensures consistent configuration across the app
  /// This is important because configuration should be shared between
  /// all parts of your application rather than duplicated
  static ConfigService get instance {
    _instance ??= ConfigService._internal();
    return _instance!;
  }

  ConfigService._internal();

  // Current active configuration
  AppConfig _currentConfig = AppConfig.defaultConfig();
  
  // Cache for loaded configurations (useful for white-labeling)
  final Map<String, AppConfig> _configCache = {};
  
  // Whether the service has been initialized
  bool _isInitialized = false;
  
  // User preferences storage
  SharedPreferences? _preferences;

  /// Public getter for current configuration
  /// ViewModels and UI components will access configuration through this
  AppConfig get currentConfig => _currentConfig;
  
  bool get isInitialized => _isInitialized;

  /// Initializes the configuration service
  /// This should be called early in your app's lifecycle, typically in main()
  /// The method loads the base configuration and any saved user preferences
  Future<void> initialize({String? brandConfigPath}) async {
    try {
      // Initialize shared preferences for user settings
      _preferences = await SharedPreferences.getInstance();
      
      // Load base configuration (either default or brand-specific)
      await _loadBaseConfiguration(brandConfigPath);
      
      // Apply any saved user preferences on top of base configuration
      await _loadUserPreferences();
      
      _isInitialized = true;
      
      // Notify listeners that configuration is ready
      notifyListeners();
      
      debugPrint('ConfigService initialized successfully');
    } catch (error) {
      debugPrint('Error initializing ConfigService: $error');
      
      // Fall back to default configuration if initialization fails
      _currentConfig = AppConfig.defaultConfig();
      _isInitialized = true;
      notifyListeners();
    }
  }

  /// Loads base configuration from assets
  /// This supports white-labeling by allowing different brand configurations
  Future<void> _loadBaseConfiguration(String? brandConfigPath) async {
    String configPath = brandConfigPath ?? 'assets/config/default_config.json';
    
    try {
      // Check if we have this configuration cached
      if (_configCache.containsKey(configPath)) {
        _currentConfig = _configCache[configPath]!;
        return;
      }

      // Load configuration from assets
      String configJson = await rootBundle.loadString(configPath);
      Map<String, dynamic> configMap = json.decode(configJson);
      
      // Parse configuration
      AppConfig config = AppConfig.fromJson(configMap);
      
      // Cache the configuration for future use
      _configCache[configPath] = config;
      _currentConfig = config;
      
      debugPrint('Loaded configuration from: $configPath');
    } catch (error) {
      debugPrint('Could not load configuration from $configPath: $error');
      
      // If we can't load a specific brand config, fall back to default
      if (brandConfigPath != null) {
        debugPrint('Falling back to default configuration');
        _currentConfig = AppConfig.defaultConfig();
      } else {
        rethrow; // If we can't even load default, that's a real problem
      }
    }
  }

  /// Loads saved user preferences and applies them to current configuration
  /// This allows users to customize their experience while maintaining
  /// the base brand configuration
  Future<void> _loadUserPreferences() async {
    if (_preferences == null) return;

    try {
      // Load theme preferences
      final themeMode = _getThemeModeFromString(
        _preferences!.getString('theme_mode') ?? 'system'
      );
      final textScaleFactor = _preferences!.getDouble('text_scale_factor') ?? 1.0;
      final reduceAnimations = _preferences!.getBool('reduce_animations') ?? false;
      final increasedContrast = _preferences!.getBool('increased_contrast') ?? false;
      
      // Load localization preferences
      final languageCode = _preferences!.getString('language_code') ?? 
          _currentConfig.localization.languageCode;
      final useDeviceLocale = _preferences!.getBool('use_device_locale') ?? true;
      
      // Load accessibility preferences
      final enableVoiceGuidance = _preferences!.getBool('enable_voice_guidance') ?? false;
      final largerTouchTargets = _preferences!.getBool('larger_touch_targets') ?? false;
      final enableHapticFeedback = _preferences!.getBool('enable_haptic_feedback') ?? true;

      // Apply user preferences to current configuration
      _currentConfig = _currentConfig.copyWith(
        theme: _currentConfig.theme.copyWith(
          themeMode: themeMode,
          textScaleFactor: textScaleFactor,
        ),
        accessibility: _currentConfig.accessibility.copyWith(
          reduceAnimations: reduceAnimations,
          increasedContrast: increasedContrast,
          enableVoiceGuidance: enableVoiceGuidance,
          largerTouchTargets: largerTouchTargets,
          enableHapticFeedback: enableHapticFeedback,
        ),
        localization: _currentConfig.localization.copyWith(
          languageCode: languageCode,
          useDeviceLocale: useDeviceLocale,
        ),
      );

      debugPrint('Applied user preferences to configuration');
    } catch (error) {
      debugPrint('Error loading user preferences: $error');
      // Continue with base configuration if preferences can't be loaded
    }
  }

  /// Updates theme configuration and saves preferences
  /// This method demonstrates how user changes flow through the MVVM system
  Future<void> updateThemeConfig(ThemeConfig newThemeConfig) async {
    _currentConfig = _currentConfig.copyWith(theme: newThemeConfig);
    
    // Save user preferences
    await _saveThemePreferences(newThemeConfig);
    
    // Notify listeners (including ViewModels) of the change
    notifyListeners();
    
    debugPrint('Theme configuration updated');
  }

  /// Updates accessibility configuration
  Future<void> updateAccessibilityConfig(AccessibilityConfig newAccessibilityConfig) async {
    _currentConfig = _currentConfig.copyWith(accessibility: newAccessibilityConfig);
    
    await _saveAccessibilityPreferences(newAccessibilityConfig);
    notifyListeners();
    
    debugPrint('Accessibility configuration updated');
  }

  /// Updates localization configuration
  Future<void> updateLocalizationConfig(LocalizationConfig newLocalizationConfig) async {
    _currentConfig = _currentConfig.copyWith(localization: newLocalizationConfig);
    
    await _saveLocalizationPreferences(newLocalizationConfig);
    notifyListeners();
    
    debugPrint('Localization configuration updated');
  }

  /// Switches to a completely different brand configuration
  /// This is the heart of white-labeling - same app, different brand
  Future<void> switchBrandConfig(String brandConfigPath) async {
    await _loadBaseConfiguration(brandConfigPath);
    await _loadUserPreferences(); // Reapply user preferences to new brand
    notifyListeners();
    
    debugPrint('Switched to brand configuration: $brandConfigPath');
  }

  /// Resets all user preferences to defaults
  Future<void> resetToDefaults() async {
    if (_preferences != null) {
      await _preferences!.clear();
    }
    
    // Reload base configuration without user preferences
    await _loadBaseConfiguration(null);
    notifyListeners();
    
    debugPrint('Reset configuration to defaults');
  }

  /// Exports current configuration to a file
  /// Useful for debugging or allowing users to share settings
  Future<File?> exportConfiguration() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/app_config_export.json');
      
      final configJson = json.encode(_currentConfig.toJson());
      await file.writeAsString(configJson);
      
      debugPrint('Configuration exported to: ${file.path}');
      return file;
    } catch (error) {
      debugPrint('Error exporting configuration: $error');
      return null;
    }
  }

  // Private helper methods for saving preferences

  Future<void> _saveThemePreferences(ThemeConfig theme) async {
    if (_preferences == null) return;
    
    await _preferences!.setString('theme_mode', _getStringFromThemeMode(theme.themeMode));
    await _preferences!.setDouble('text_scale_factor', theme.textScaleFactor);
  }

  Future<void> _saveAccessibilityPreferences(AccessibilityConfig accessibility) async {
    if (_preferences == null) return;
    
    await _preferences!.setBool('reduce_animations', accessibility.reduceAnimations);
    await _preferences!.setBool('increased_contrast', accessibility.increasedContrast);
    await _preferences!.setBool('enable_voice_guidance', accessibility.enableVoiceGuidance);
    await _preferences!.setBool('larger_touch_targets', accessibility.largerTouchTargets);
    await _preferences!.setBool('enable_haptic_feedback', accessibility.enableHapticFeedback);
  }

  Future<void> _saveLocalizationPreferences(LocalizationConfig localization) async {
    if (_preferences == null) return;
    
    await _preferences!.setString('language_code', localization.languageCode);
    await _preferences!.setBool('use_device_locale', localization.useDeviceLocale);
  }

  // Helper methods for enum conversions

  ThemeMode _getThemeModeFromString(String value) {
    switch (value) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      case 'system': return ThemeMode.system;
      default: return ThemeMode.system;
    }
  }

  String _getStringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light: return 'light';
      case ThemeMode.dark: return 'dark';
      case ThemeMode.system: return 'system';
    }
  }

  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }
}

/// Extension methods to make working with configurations easier in your ViewModels
extension ConfigServiceExtensions on ConfigService {
  /// Quick access to brand colors for UI components
  BrandConfig get brand => currentConfig.brand;
  ThemeConfig get theme => currentConfig.theme;
  AccessibilityConfig get accessibility => currentConfig.accessibility;
  FeatureFlags get features => currentConfig.features;
  LocalizationConfig get localization => currentConfig.localization;
  
  /// Convenience method to check if a feature is enabled
  /// This makes your ViewModels more readable
  bool isFeatureEnabled(String featureName) {
    return features.customFeatures[featureName] ?? false;
  }
  
  /// Quick access to commonly used accessibility settings
  bool get shouldReduceAnimations => accessibility.reduceAnimations;
  bool get shouldUseHighContrast => accessibility.increasedContrast;
  bool get shouldUseLargerTouchTargets => accessibility.largerTouchTargets;
}