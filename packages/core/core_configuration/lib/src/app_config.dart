import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_config.g.dart';

/// Custom converter for [VisualDensity].
class VisualDensityConverter implements JsonConverter<VisualDensity, String> {
  /// Creates a [VisualDensityConverter].
  const VisualDensityConverter();

  /// Converts a JSON string to [VisualDensity].
  @override
  VisualDensity fromJson(String json) {
    switch (json) {
      case 'compact':
        return VisualDensity.compact;
      case 'comfortable':
        return VisualDensity.comfortable;
      case 'standard':
      default:
        return VisualDensity.standard;
    }
  }

  /// Converts a [VisualDensity] to a JSON string.
  @override
  String toJson(VisualDensity object) {
    if (object == VisualDensity.compact) return 'compact';
    if (object == VisualDensity.comfortable) return 'comfortable';
    return 'standard';
  }
}

/// App configuration model.
@JsonSerializable()
class AppConfig {
  /// Creates an [AppConfig].
  const AppConfig({
    required this.brand,
    required this.theme,
    required this.accessibility,
    required this.features,
    required this.localization,
  });

  /// Creates an [AppConfig] from JSON.
  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  /// Returns the default [AppConfig].
  factory AppConfig.defaultConfig() {
    return AppConfig(
      brand: BrandConfig.defaultBrand(),
      theme: ThemeConfig.defaultTheme(),
      accessibility: AccessibilityConfig.defaultConfig(),
      features: FeatureFlags.defaultFlags(),
      localization: LocalizationConfig.defaultConfig(),
    );
  }

  /// Brand configuration.
  final BrandConfig brand;

  /// Theme configuration.
  final ThemeConfig theme;

  /// Accessibility configuration.
  final AccessibilityConfig accessibility;

  /// Feature flags.
  final FeatureFlags features;

  /// Localization configuration.
  final LocalizationConfig localization;

  /// Converts this object to JSON.
  Map<String, dynamic> toJson() => _$AppConfigToJson(this);

  /// Returns a copy of this object with updated fields.
  AppConfig copyWith({
    BrandConfig? brand,
    ThemeConfig? theme,
    AccessibilityConfig? accessibility,
    FeatureFlags? features,
    LocalizationConfig? localization,
  }) {
    return AppConfig(
      brand: brand ?? this.brand,
      theme: theme ?? this.theme,
      accessibility: accessibility ?? this.accessibility,
      features: features ?? this.features,
      localization: localization ?? this.localization,
    );
  }
}

/// Brand configuration model.
@JsonSerializable()
class BrandConfig {
  /// Creates a [BrandConfig].
  const BrandConfig({
    required this.appName,
    required this.logoPath,
    required this.primaryColorHex,
    required this.secondaryColorHex,
    required this.accentColorHex,
    required this.fontFamily,
    required this.websiteUrl,
    required this.supportEmail,
    required this.customAssets,
  });

  /// Creates a [BrandConfig] from JSON.
  factory BrandConfig.fromJson(Map<String, dynamic> json) =>
      _$BrandConfigFromJson(json);

  /// Returns the default [BrandConfig].
  factory BrandConfig.defaultBrand() {
    return const BrandConfig(
      appName: 'MVVM Demo',
      logoPath: 'assets/brand/default_logo.png',
      primaryColorHex: '#6750A4',
      secondaryColorHex: '#625B71',
      accentColorHex: '#7D5260',
      fontFamily: 'Roboto',
      websiteUrl: 'https://example.com',
      supportEmail: 'support@example.com',
      customAssets: {},
    );
  }

  /// Application name.
  final String appName;

  /// Path to the logo asset.
  final String logoPath;

  /// Primary color in hex.
  final String primaryColorHex;

  /// Secondary color in hex.
  final String secondaryColorHex;

  /// Accent color in hex.
  final String accentColorHex;

  /// Font family.
  final String fontFamily;

  /// Website URL.
  final String websiteUrl;

  /// Support email address.
  final String supportEmail;

  /// Custom assets.
  final Map<String, String> customAssets;

  /// Converts this object to JSON.
  Map<String, dynamic> toJson() => _$BrandConfigToJson(this);

  /// Gets the primary color.
  Color get primaryColor =>
      Color(int.parse(primaryColorHex.substring(1), radix: 16) + 0xFF000000);

  /// Gets the secondary color.
  Color get secondaryColor =>
      Color(int.parse(secondaryColorHex.substring(1), radix: 16) + 0xFF000000);

  /// Gets the accent color.
  Color get accentColor =>
      Color(int.parse(accentColorHex.substring(1), radix: 16) + 0xFF000000);

  /// Returns a copy of this object with updated fields.
  BrandConfig copyWith({
    String? appName,
    String? logoPath,
    String? primaryColorHex,
    String? secondaryColorHex,
    String? accentColorHex,
    String? fontFamily,
    String? websiteUrl,
    String? supportEmail,
    Map<String, String>? customAssets,
  }) {
    return BrandConfig(
      appName: appName ?? this.appName,
      logoPath: logoPath ?? this.logoPath,
      primaryColorHex: primaryColorHex ?? this.primaryColorHex,
      secondaryColorHex: secondaryColorHex ?? this.secondaryColorHex,
      accentColorHex: accentColorHex ?? this.accentColorHex,
      fontFamily: fontFamily ?? this.fontFamily,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      supportEmail: supportEmail ?? this.supportEmail,
      customAssets: customAssets ?? this.customAssets,
    );
  }
}

/// Theme configuration model.
@JsonSerializable()
class ThemeConfig {
  /// Creates a [ThemeConfig].
  const ThemeConfig({
    required this.themeMode,
    required this.textScaleFactor,
    required this.visualDensity,
    required this.useSystemAccentColor,
    required this.useMaterial3,
    required this.customColors,
  });

  /// Creates a [ThemeConfig] from JSON.
  factory ThemeConfig.fromJson(Map<String, dynamic> json) =>
      _$ThemeConfigFromJson(json);

  /// Returns the default [ThemeConfig].
  factory ThemeConfig.defaultTheme() {
    return const ThemeConfig(
      themeMode: ThemeMode.system,
      textScaleFactor: 1,
      visualDensity: VisualDensity.standard,
      useSystemAccentColor: true,
      useMaterial3: true,
      customColors: {},
    );
  }

  /// Theme mode.
  final ThemeMode themeMode;

  /// Text scale factor.
  final double textScaleFactor;

  /// Visual density.
  @VisualDensityConverter()
  final VisualDensity visualDensity;

  /// Whether to use system accent color.
  final bool useSystemAccentColor;

  /// Whether to use Material 3.
  final bool useMaterial3;

  /// Custom colors.
  final Map<String, String> customColors;

  /// Converts this object to JSON.
  Map<String, dynamic> toJson() => _$ThemeConfigToJson(this);

  /// Returns a copy of this object with updated fields.
  ThemeConfig copyWith({
    ThemeMode? themeMode,
    double? textScaleFactor,
    VisualDensity? visualDensity,
    bool? useSystemAccentColor,
    bool? useMaterial3,
    Map<String, String>? customColors,
  }) {
    return ThemeConfig(
      themeMode: themeMode ?? this.themeMode,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      visualDensity: visualDensity ?? this.visualDensity,
      useSystemAccentColor: useSystemAccentColor ?? this.useSystemAccentColor,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      customColors: customColors ?? this.customColors,
    );
  }
}

/// Accessibility configuration model.
@JsonSerializable()
class AccessibilityConfig {
  /// Creates an [AccessibilityConfig].
  const AccessibilityConfig({
    required this.enableScreenReader,
    required this.enableVoiceGuidance,
    required this.reduceAnimations,
    required this.increasedContrast,
    required this.largerTouchTargets,
    required this.minimumTouchSize,
    required this.enableSemanticLabels,
    required this.enableHapticFeedback,
  });

  /// Creates an [AccessibilityConfig] from JSON.
  factory AccessibilityConfig.fromJson(Map<String, dynamic> json) =>
      _$AccessibilityConfigFromJson(json);

  /// Returns the default [AccessibilityConfig].
  factory AccessibilityConfig.defaultConfig() {
    return const AccessibilityConfig(
      enableScreenReader: true,
      enableVoiceGuidance: false,
      reduceAnimations: false,
      increasedContrast: false,
      largerTouchTargets: false,
      minimumTouchSize: 44,
      enableSemanticLabels: true,
      enableHapticFeedback: true,
    );
  }

  /// Whether screen reader is enabled.
  final bool enableScreenReader;

  /// Whether voice guidance is enabled.
  final bool enableVoiceGuidance;

  /// Whether animations are reduced.
  final bool reduceAnimations;

  /// Whether contrast is increased.
  final bool increasedContrast;

  /// Whether larger touch targets are enabled.
  final bool largerTouchTargets;

  /// Minimum touch size.
  final double minimumTouchSize;

  /// Whether semantic labels are enabled.
  final bool enableSemanticLabels;

  /// Whether haptic feedback is enabled.
  final bool enableHapticFeedback;

  /// Converts this object to JSON.
  Map<String, dynamic> toJson() => _$AccessibilityConfigToJson(this);

  /// Returns a copy of this object with updated fields.
  AccessibilityConfig copyWith({
    bool? enableScreenReader,
    bool? enableVoiceGuidance,
    bool? reduceAnimations,
    bool? increasedContrast,
    bool? largerTouchTargets,
    double? minimumTouchSize,
    bool? enableSemanticLabels,
    bool? enableHapticFeedback,
  }) {
    return AccessibilityConfig(
      enableScreenReader: enableScreenReader ?? this.enableScreenReader,
      enableVoiceGuidance: enableVoiceGuidance ?? this.enableVoiceGuidance,
      reduceAnimations: reduceAnimations ?? this.reduceAnimations,
      increasedContrast: increasedContrast ?? this.increasedContrast,
      largerTouchTargets: largerTouchTargets ?? this.largerTouchTargets,
      minimumTouchSize: minimumTouchSize ?? this.minimumTouchSize,
      enableSemanticLabels: enableSemanticLabels ?? this.enableSemanticLabels,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
    );
  }
}

/// Feature flags configuration model.
@JsonSerializable()
class FeatureFlags {
  /// Creates a [FeatureFlags].
  const FeatureFlags({
    required this.enableUserProfiles,
    required this.enableItemReordering,
    required this.enableColorCustomization,
    required this.enableDataExport,
    required this.enableOfflineMode,
    required this.enableAnalytics,
    required this.enablePushNotifications,
    required this.customFeatures,
  });

  /// Creates a [FeatureFlags] from JSON.
  factory FeatureFlags.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsFromJson(json);

  /// Returns the default [FeatureFlags].
  factory FeatureFlags.defaultFlags() {
    return const FeatureFlags(
      enableUserProfiles: true,
      enableItemReordering: true,
      enableColorCustomization: true,
      enableDataExport: false,
      enableOfflineMode: false,
      enableAnalytics: true,
      enablePushNotifications: false,
      customFeatures: {},
    );
  }

  /// Whether user profiles are enabled.
  final bool enableUserProfiles;

  /// Whether item reordering is enabled.
  final bool enableItemReordering;

  /// Whether color customization is enabled.
  final bool enableColorCustomization;

  /// Whether data export is enabled.
  final bool enableDataExport;

  /// Whether offline mode is enabled.
  final bool enableOfflineMode;

  /// Whether analytics is enabled.
  final bool enableAnalytics;

  /// Whether push notifications are enabled.
  final bool enablePushNotifications;

  /// Custom feature flags.
  final Map<String, bool> customFeatures;

  /// Converts this object to JSON.
  Map<String, dynamic> toJson() => _$FeatureFlagsToJson(this);

  /// Returns a copy of this object with updated fields.
  FeatureFlags copyWith({
    bool? enableUserProfiles,
    bool? enableItemReordering,
    bool? enableColorCustomization,
    bool? enableDataExport,
    bool? enableOfflineMode,
    bool? enableAnalytics,
    bool? enablePushNotifications,
    Map<String, bool>? customFeatures,
  }) {
    return FeatureFlags(
      enableUserProfiles: enableUserProfiles ?? this.enableUserProfiles,
      enableItemReordering: enableItemReordering ?? this.enableItemReordering,
      enableColorCustomization:
          enableColorCustomization ?? this.enableColorCustomization,
      enableDataExport: enableDataExport ?? this.enableDataExport,
      enableOfflineMode: enableOfflineMode ?? this.enableOfflineMode,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      customFeatures: customFeatures ?? this.customFeatures,
    );
  }
}

/// Localization configuration model.
@JsonSerializable()
class LocalizationConfig {
  /// Creates a [LocalizationConfig].
  const LocalizationConfig({
    required this.languageCode,
    required this.useDeviceLocale,
    required this.dateFormat,
    required this.timeFormat,
    required this.numberFormat,
    this.countryCode,
  });

  /// Creates a [LocalizationConfig] from JSON.
  factory LocalizationConfig.fromJson(Map<String, dynamic> json) =>
      _$LocalizationConfigFromJson(json);

  /// Returns the default [LocalizationConfig].
  factory LocalizationConfig.defaultConfig() {
    return const LocalizationConfig(
      languageCode: 'en',
      countryCode: 'US',
      useDeviceLocale: true,
      dateFormat: 'MM/dd/yyyy',
      timeFormat: '12h',
      numberFormat: 'en_US',
    );
  }

  /// Language code.
  final String languageCode;

  /// Country code.
  final String? countryCode;

  /// Whether to use device locale.
  final bool useDeviceLocale;

  /// Date format.
  final String dateFormat;

  /// Time format.
  final String timeFormat;

  /// Number format.
  final String numberFormat;

  /// Converts this object to JSON.
  Map<String, dynamic> toJson() => _$LocalizationConfigToJson(this);

  /// Gets the [Locale] for this configuration.
  Locale get locale => Locale(languageCode, countryCode);

  /// Returns a copy of this object with updated fields.
  LocalizationConfig copyWith({
    String? languageCode,
    String? countryCode,
    bool? useDeviceLocale,
    String? dateFormat,
    String? timeFormat,
    String? numberFormat,
  }) {
    return LocalizationConfig(
      languageCode: languageCode ?? this.languageCode,
      countryCode: countryCode ?? this.countryCode,
      useDeviceLocale: useDeviceLocale ?? this.useDeviceLocale,
      dateFormat: dateFormat ?? this.dateFormat,
      timeFormat: timeFormat ?? this.timeFormat,
      numberFormat: numberFormat ?? this.numberFormat,
    );
  }
}
