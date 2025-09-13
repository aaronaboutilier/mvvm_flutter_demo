import 'dart:convert';
import 'dart:io';

import 'package:core_configuration/src/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing app configuration and preferences.
class ConfigService extends ChangeNotifier {
  /// Factory constructor for singleton access.
  factory ConfigService() {
    _instance ??= ConfigService._internal();
    return _instance!;
  }

  /// Internal constructor for singleton.
  ConfigService._internal();

  /// Singleton instance.
  static ConfigService? _instance;

  /// Current app configuration.
  AppConfig _currentConfig = AppConfig.defaultConfig();

  /// Cache for loaded configurations.
  final Map<String, AppConfig> _configCache = {};

  /// Whether the service is initialized.
  bool _isInitialized = false;

  /// Shared preferences instance.
  SharedPreferences? _preferences;

  /// Gets the current app configuration.
  AppConfig get currentConfig => _currentConfig;

  /// Whether the service is initialized.
  bool get isInitialized => _isInitialized;

  /// Initializes the configuration service.
  Future<void> initialize({String? brandConfigPath}) async {
    try {
      _preferences = await SharedPreferences.getInstance();
      await _loadBaseConfiguration(brandConfigPath);
      await _loadUserPreferences();
      _isInitialized = true;
      notifyListeners();
    } catch (_) {
      _currentConfig = AppConfig.defaultConfig();
      _isInitialized = true;
      notifyListeners();
    }
  }

  /// Loads the base configuration from assets or cache.
  Future<void> _loadBaseConfiguration(String? brandConfigPath) async {
    final configPath = brandConfigPath ?? 'assets/config/default_config.json';
    try {
      if (_configCache.containsKey(configPath)) {
        _currentConfig = _configCache[configPath]!;
        return;
      }
      final configJson = await rootBundle.loadString(configPath);
      final configMap = json.decode(configJson) as Map<String, dynamic>;
      final config = AppConfig.fromJson(configMap);
      _configCache[configPath] = config;
      _currentConfig = config;
    } catch (_) {
      if (brandConfigPath != null) {
        _currentConfig = AppConfig.defaultConfig();
      } else {
        rethrow;
      }
    }
  }

  /// Loads user preferences and applies them to the configuration.
  Future<void> _loadUserPreferences() async {
    if (_preferences == null) return;
    try {
      final themeMode = _getThemeModeFromString(
        _preferences!.getString('theme_mode') ?? 'system',
      );
      final textScaleFactor =
          _preferences!.getDouble('text_scale_factor') ?? 1.0;
      final reduceAnimations =
          _preferences!.getBool('reduce_animations') ?? false;
      final increasedContrast =
          _preferences!.getBool('increased_contrast') ?? false;
      final languageCode =
          _preferences!.getString('language_code') ??
          _currentConfig.localization.languageCode;
      final useDeviceLocale =
          _preferences!.getBool('use_device_locale') ?? true;
      final enableVoiceGuidance =
          _preferences!.getBool('enable_voice_guidance') ?? false;
      final largerTouchTargets =
          _preferences!.getBool('larger_touch_targets') ?? false;
      final enableHapticFeedback =
          _preferences!.getBool('enable_haptic_feedback') ?? true;

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
    } catch (_) {}
  }

  /// Updates the theme configuration.
  Future<void> updateThemeConfig(ThemeConfig newThemeConfig) async {
    _currentConfig = _currentConfig.copyWith(theme: newThemeConfig);
    await _saveThemePreferences(newThemeConfig);
    notifyListeners();
  }

  /// Updates the accessibility configuration.
  Future<void> updateAccessibilityConfig(
    AccessibilityConfig newAccessibilityConfig,
  ) async {
    _currentConfig = _currentConfig.copyWith(
      accessibility: newAccessibilityConfig,
    );
    await _saveAccessibilityPreferences(newAccessibilityConfig);
    notifyListeners();
  }

  /// Updates the localization configuration.
  Future<void> updateLocalizationConfig(
    LocalizationConfig newLocalizationConfig,
  ) async {
    _currentConfig = _currentConfig.copyWith(
      localization: newLocalizationConfig,
    );
    await _saveLocalizationPreferences(newLocalizationConfig);
    notifyListeners();
  }

  /// Switches to a different brand configuration.
  Future<void> switchBrandConfig(String brandConfigPath) async {
    await _loadBaseConfiguration(brandConfigPath);
    await _loadUserPreferences();
    notifyListeners();
  }

  /// Resets configuration and preferences to default values.
  Future<void> resetToDefaults() async {
    if (_preferences != null) {
      await _preferences!.clear();
    }
    await _loadBaseConfiguration(null);
    notifyListeners();
  }

  /// Exports the current configuration to a file.
  Future<File?> exportConfiguration() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/app_config_export.json');
      final configJson = json.encode(_currentConfig.toJson());
      await file.writeAsString(configJson);
      return file;
    } catch (_) {
      return null;
    }
  }

  /// Saves theme preferences.
  Future<void> _saveThemePreferences(ThemeConfig theme) async {
    if (_preferences == null) return;
    await _preferences!.setString(
      'theme_mode',
      _getStringFromThemeMode(theme.themeMode),
    );
    await _preferences!.setDouble('text_scale_factor', theme.textScaleFactor);
  }

  /// Saves accessibility preferences.
  Future<void> _saveAccessibilityPreferences(
    AccessibilityConfig accessibility,
  ) async {
    if (_preferences == null) return;
    await _preferences!.setBool(
      'reduce_animations',
      accessibility.reduceAnimations,
    );
    await _preferences!.setBool(
      'increased_contrast',
      accessibility.increasedContrast,
    );
    await _preferences!.setBool(
      'enable_voice_guidance',
      accessibility.enableVoiceGuidance,
    );
    await _preferences!.setBool(
      'larger_touch_targets',
      accessibility.largerTouchTargets,
    );
    await _preferences!.setBool(
      'enable_haptic_feedback',
      accessibility.enableHapticFeedback,
    );
  }

  /// Saves localization preferences.
  Future<void> _saveLocalizationPreferences(
    LocalizationConfig localization,
  ) async {
    if (_preferences == null) return;
    await _preferences!.setString('language_code', localization.languageCode);
    await _preferences!.setBool(
      'use_device_locale',
      localization.useDeviceLocale,
    );
  }

  /// Converts a string to [ThemeMode].
  ThemeMode _getThemeModeFromString(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Converts a [ThemeMode] to string.
  String _getStringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  /// Disposes the service and resets the singleton instance.
  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }
}

/// Extension for convenient access to configuration properties.
extension ConfigServiceExtensions on ConfigService {
  /// Gets the brand configuration.
  BrandConfig get brand => currentConfig.brand;

  /// Gets the theme configuration.
  ThemeConfig get theme => currentConfig.theme;

  /// Gets the accessibility configuration.
  AccessibilityConfig get accessibility => currentConfig.accessibility;

  /// Gets the feature flags.
  FeatureFlags get features => currentConfig.features;

  /// Gets the localization configuration.
  LocalizationConfig get localization => currentConfig.localization;

  /// Checks if a feature is enabled by name.
  bool isFeatureEnabled(String featureName) {
    return features.customFeatures[featureName] ?? false;
  }

  /// Whether animations should be reduced.
  bool get shouldReduceAnimations => accessibility.reduceAnimations;

  /// Whether high contrast should be used.
  bool get shouldUseHighContrast => accessibility.increasedContrast;

  /// Whether larger touch targets should be used.
  bool get shouldUseLargerTouchTargets => accessibility.largerTouchTargets;
}
