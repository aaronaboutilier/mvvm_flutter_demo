import 'package:flutter/material.dart';

/// Theme-related user preferences.
class ThemeSettings {
  /// Creates theme settings with a [themeMode] and [textScaleFactor].
  const ThemeSettings({
    required this.themeMode,
    required this.textScaleFactor,
    this.accentColorKey = 'primary',
  });

  /// The current theme mode.
  final ThemeMode themeMode;

  /// The text scale factor applied to the UI (1.0 is default).
  final double textScaleFactor;

  /// Key for accent/seed color, matched to core_design_system tokens.
  /// e.g. 'primary' | 'secondary' | 'success' | 'danger'.
  final String accentColorKey;

  /// Returns a new [ThemeSettings] with selectively overridden values.
  ThemeSettings copyWith({
    ThemeMode? themeMode,
    double? textScaleFactor,
    String? accentColorKey,
  }) => ThemeSettings(
    themeMode: themeMode ?? this.themeMode,
    textScaleFactor: textScaleFactor ?? this.textScaleFactor,
    accentColorKey: accentColorKey ?? this.accentColorKey,
  );
}

/// Accessibility options that improve usability for different needs.
class AccessibilitySettings {
  /// Creates accessibility settings.
  const AccessibilitySettings({
    required this.reduceAnimations,
    required this.increasedContrast,
    required this.largerTouchTargets,
    required this.enableVoiceGuidance,
    required this.enableHapticFeedback,
  });

  /// Whether to reduce or disable animations.
  final bool reduceAnimations;

  /// Whether to increase color contrast.
  final bool increasedContrast;

  /// Whether to use larger touch targets for controls.
  final bool largerTouchTargets;

  /// Whether voice guidance is enabled.
  final bool enableVoiceGuidance;

  /// Whether haptic feedback is enabled.
  final bool enableHapticFeedback;

  /// Returns a new [AccessibilitySettings] with selectively overridden values.
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

/// Localization options that control language behavior.
class LocalizationSettings {
  /// Creates localization settings.
  const LocalizationSettings({
    required this.useDeviceLocale,
    required this.languageCode,
  });

  /// True to use the device locale automatically.
  final bool useDeviceLocale;

  /// ISO language code to use when not using the device locale.
  final String languageCode;

  /// Returns a new [LocalizationSettings] with selectively overridden values.
  LocalizationSettings copyWith({
    bool? useDeviceLocale,
    String? languageCode,
  }) => LocalizationSettings(
    useDeviceLocale: useDeviceLocale ?? this.useDeviceLocale,
    languageCode: languageCode ?? this.languageCode,
  );
}

/// Basic brand information for the application.
class BrandInfo {
  /// Creates brand info.
  const BrandInfo({
    required this.appName,
    required this.websiteUrl,
    required this.supportEmail,
  });

  /// The display name of the app.
  final String appName;

  /// The website URL associated with the brand.
  final String websiteUrl;

  /// Support contact email address.
  final String supportEmail;
}

/// Feature flags that enable or disable capabilities.
class FeatureSettings {
  /// Creates feature settings.
  const FeatureSettings({required this.enableDataExport});

  /// Whether data export is enabled in this build.
  final bool enableDataExport;
}

/// Aggregate of all configurable settings for the app.
class SettingsConfig {
  /// Creates a complete settings configuration.
  const SettingsConfig({
    required this.theme,
    required this.accessibility,
    required this.localization,
    required this.brand,
    required this.features,
  });

  /// Theme preferences section.
  final ThemeSettings theme;

  /// Accessibility preferences section.
  final AccessibilitySettings accessibility;

  /// Localization preferences section.
  final LocalizationSettings localization;

  /// Branding information.
  final BrandInfo brand;

  /// Feature flags.
  final FeatureSettings features;
}
