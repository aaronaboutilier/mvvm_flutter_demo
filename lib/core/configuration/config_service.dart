import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'app_config.dart';

class ConfigService extends ChangeNotifier {
  static ConfigService? _instance;
  static ConfigService get instance {
    _instance ??= ConfigService._internal();
    return _instance!;
  }

  ConfigService._internal();

  AppConfig _currentConfig = AppConfig.defaultConfig();
  final Map<String, AppConfig> _configCache = {};
  bool _isInitialized = false;
  SharedPreferences? _preferences;

  AppConfig get currentConfig => _currentConfig;
  bool get isInitialized => _isInitialized;

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

  Future<void> _loadBaseConfiguration(String? brandConfigPath) async {
    String configPath = brandConfigPath ?? 'assets/config/default_config.json';
    try {
      if (_configCache.containsKey(configPath)) {
        _currentConfig = _configCache[configPath]!;
        return;
      }
  String configJson = await rootBundle.loadString(configPath);
  final Map<String, dynamic> configMap = json.decode(configJson) as Map<String, dynamic>;
      AppConfig config = AppConfig.fromJson(configMap);
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

  Future<void> _loadUserPreferences() async {
    if (_preferences == null) return;
    try {
      final themeMode = _getThemeModeFromString(
          _preferences!.getString('theme_mode') ?? 'system');
      final textScaleFactor =
          _preferences!.getDouble('text_scale_factor') ?? 1.0;
      final reduceAnimations =
          _preferences!.getBool('reduce_animations') ?? false;
      final increasedContrast =
          _preferences!.getBool('increased_contrast') ?? false;
      final languageCode = _preferences!.getString('language_code') ??
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

  Future<void> updateThemeConfig(ThemeConfig newThemeConfig) async {
    _currentConfig = _currentConfig.copyWith(theme: newThemeConfig);
    await _saveThemePreferences(newThemeConfig);
    notifyListeners();
  }

  Future<void> updateAccessibilityConfig(
      AccessibilityConfig newAccessibilityConfig) async {
    _currentConfig = _currentConfig.copyWith(accessibility: newAccessibilityConfig);
    await _saveAccessibilityPreferences(newAccessibilityConfig);
    notifyListeners();
  }

  Future<void> updateLocalizationConfig(
      LocalizationConfig newLocalizationConfig) async {
    _currentConfig = _currentConfig.copyWith(localization: newLocalizationConfig);
    await _saveLocalizationPreferences(newLocalizationConfig);
    notifyListeners();
  }

  Future<void> switchBrandConfig(String brandConfigPath) async {
    await _loadBaseConfiguration(brandConfigPath);
    await _loadUserPreferences();
    notifyListeners();
  }

  Future<void> resetToDefaults() async {
    if (_preferences != null) {
      await _preferences!.clear();
    }
    await _loadBaseConfiguration(null);
    notifyListeners();
  }

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

  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }
}

extension ConfigServiceExtensions on ConfigService {
  BrandConfig get brand => currentConfig.brand;
  ThemeConfig get theme => currentConfig.theme;
  AccessibilityConfig get accessibility => currentConfig.accessibility;
  FeatureFlags get features => currentConfig.features;
  LocalizationConfig get localization => currentConfig.localization;

  bool isFeatureEnabled(String featureName) {
    return features.customFeatures[featureName] ?? false;
  }

  bool get shouldReduceAnimations => accessibility.reduceAnimations;
  bool get shouldUseHighContrast => accessibility.increasedContrast;
  bool get shouldUseLargerTouchTargets => accessibility.largerTouchTargets;
}
