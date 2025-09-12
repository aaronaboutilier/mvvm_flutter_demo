import 'package:flutter/material.dart';

class ThemeSettings {
  final ThemeMode themeMode;
  final double textScaleFactor;
  const ThemeSettings({required this.themeMode, required this.textScaleFactor});

  ThemeSettings copyWith({ThemeMode? themeMode, double? textScaleFactor}) => ThemeSettings(
        themeMode: themeMode ?? this.themeMode,
        textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      );
}

class AccessibilitySettings {
  final bool reduceAnimations;
  final bool increasedContrast;
  final bool largerTouchTargets;
  final bool enableVoiceGuidance;
  final bool enableHapticFeedback;

  const AccessibilitySettings({
    required this.reduceAnimations,
    required this.increasedContrast,
    required this.largerTouchTargets,
    required this.enableVoiceGuidance,
    required this.enableHapticFeedback,
  });

  AccessibilitySettings copyWith({
    bool? reduceAnimations,
    bool? increasedContrast,
    bool? largerTouchTargets,
    bool? enableVoiceGuidance,
    bool? enableHapticFeedback,
  }) => AccessibilitySettings(
        reduceAnimations: reduceAnimations ?? this.reduceAnimations,
        increasedContrast: increasedContrast ?? this.increasedContrast,
        largerTouchTargets: largerTouchTargets ?? this.largerTouchTargets,
        enableVoiceGuidance: enableVoiceGuidance ?? this.enableVoiceGuidance,
        enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      );
}

class LocalizationSettings {
  final bool useDeviceLocale;
  final String languageCode;
  const LocalizationSettings({required this.useDeviceLocale, required this.languageCode});

  LocalizationSettings copyWith({bool? useDeviceLocale, String? languageCode}) => LocalizationSettings(
        useDeviceLocale: useDeviceLocale ?? this.useDeviceLocale,
        languageCode: languageCode ?? this.languageCode,
      );
}

class BrandInfo {
  final String appName;
  final String websiteUrl;
  final String supportEmail;
  const BrandInfo({required this.appName, required this.websiteUrl, required this.supportEmail});
}

class FeatureSettings {
  final bool enableDataExport;
  const FeatureSettings({required this.enableDataExport});
}

class SettingsConfig {
  final ThemeSettings theme;
  final AccessibilitySettings accessibility;
  final LocalizationSettings localization;
  final BrandInfo brand;
  final FeatureSettings features;

  const SettingsConfig({
    required this.theme,
    required this.accessibility,
    required this.localization,
    required this.brand,
    required this.features,
  });
}
