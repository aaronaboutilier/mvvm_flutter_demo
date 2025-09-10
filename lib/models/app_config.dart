// lib/models/app_config.dart

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_config.g.dart';

/// Custom converter for VisualDensity
class VisualDensityConverter implements JsonConverter<VisualDensity, String> {
  const VisualDensityConverter();

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

  @override
  String toJson(VisualDensity object) {
    if (object == VisualDensity.compact) return 'compact';
    if (object == VisualDensity.comfortable) return 'comfortable';
    return 'standard';
  }
}

/// AppConfig represents the complete configuration for theming, white-labeling,
/// and accessibility features. This is the central model that drives your app's
/// appearance and behavior, making it easy to create different branded versions
/// or adapt to user preferences.
/// 
/// The beauty of this approach in MVVM is that your ViewModels remain unchanged
/// while the entire app appearance can be transformed through configuration.
@JsonSerializable()
class AppConfig {
  // Brand configuration for white-labeling
  final BrandConfig brand;
  
  // Theme configuration for light/dark modes and custom styling
  final ThemeConfig theme;
  
  // Accessibility configuration
  final AccessibilityConfig accessibility;
  
  // Feature flags for controlling app behavior
  final FeatureFlags features;
  
  // Localization preferences
  final LocalizationConfig localization;

  const AppConfig({
    required this.brand,
    required this.theme,
    required this.accessibility,
    required this.features,
    required this.localization,
  });

  /// Creates AppConfig from JSON - useful for loading from assets or remote config
  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);
  
  /// Converts AppConfig to JSON - useful for saving user preferences
  Map<String, dynamic> toJson() => _$AppConfigToJson(this);

  /// Creates a default configuration - this is your fallback when no config is provided
  factory AppConfig.defaultConfig() {
    return AppConfig(
      brand: BrandConfig.defaultBrand(),
      theme: ThemeConfig.defaultTheme(),
      accessibility: AccessibilityConfig.defaultConfig(),
      features: FeatureFlags.defaultFlags(),
      localization: LocalizationConfig.defaultConfig(),
    );
  }

  /// Creates a copy with updated values - essential for immutable configuration updates
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

/// BrandConfig contains all white-label customization options
/// This allows you to completely rebrand your app without code changes
@JsonSerializable()
class BrandConfig {
  final String appName;
  final String logoPath;
  final String primaryColorHex;
  final String secondaryColorHex;
  final String accentColorHex;
  final String fontFamily;
  final String websiteUrl;
  final String supportEmail;
  final Map<String, String> customAssets; // For additional branded assets

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

  factory BrandConfig.fromJson(Map<String, dynamic> json) => _$BrandConfigFromJson(json);
  Map<String, dynamic> toJson() => _$BrandConfigToJson(this);

  factory BrandConfig.defaultBrand() {
    return const BrandConfig(
      appName: 'MVVM Demo',
      logoPath: 'assets/brand/default_logo.png',
      primaryColorHex: '#6750A4',      // Material 3 purple
      secondaryColorHex: '#625B71',    // Material 3 secondary
      accentColorHex: '#7D5260',       // Material 3 tertiary
      fontFamily: 'Roboto',
      websiteUrl: 'https://example.com',
      supportEmail: 'support@example.com',
      customAssets: {},
    );
  }

  // Helper getters to convert hex colors to Flutter Color objects
  Color get primaryColor => Color(int.parse(primaryColorHex.substring(1), radix: 16) + 0xFF000000);
  Color get secondaryColor => Color(int.parse(secondaryColorHex.substring(1), radix: 16) + 0xFF000000);
  Color get accentColor => Color(int.parse(accentColorHex.substring(1), radix: 16) + 0xFF000000);

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

/// ThemeConfig manages visual appearance and user preferences
/// This includes dark mode, text scaling, and visual density options
@JsonSerializable()
class ThemeConfig {
  final ThemeMode themeMode;           // light, dark, or system
  final double textScaleFactor;        // Accessibility text scaling
  @VisualDensityConverter()
  final VisualDensity visualDensity;   // UI density (compact, standard, comfortable)
  final bool useSystemAccentColor;     // Whether to use system accent color (Android 12+)
  final bool useMaterial3;             // Whether to use Material 3 design
  final Map<String, String> customColors; // Additional color overrides

  const ThemeConfig({
    required this.themeMode,
    required this.textScaleFactor,
    required this.visualDensity,
    required this.useSystemAccentColor,
    required this.useMaterial3,
    required this.customColors,
  });

  factory ThemeConfig.fromJson(Map<String, dynamic> json) => _$ThemeConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ThemeConfigToJson(this);

  factory ThemeConfig.defaultTheme() {
    return const ThemeConfig(
      themeMode: ThemeMode.system,
      textScaleFactor: 1.0,
      visualDensity: VisualDensity.standard,
      useSystemAccentColor: true,
      useMaterial3: true,
      customColors: {},
    );
  }

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

/// AccessibilityConfig manages accessibility features and preferences
/// This ensures your app works well for users with disabilities
@JsonSerializable()
class AccessibilityConfig {
  final bool enableScreenReader;       // Screen reader optimizations
  final bool enableVoiceGuidance;      // Text-to-speech features
  final bool reduceAnimations;         // Reduced motion for sensitive users
  final bool increasedContrast;        // High contrast mode
  final bool largerTouchTargets;       // Bigger tap areas for motor difficulties
  final double minimumTouchSize;       // Minimum touch target size in logical pixels
  final bool enableSemanticLabels;     // Enhanced semantic descriptions
  final bool enableHapticFeedback;     // Vibration feedback for interactions

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

  factory AccessibilityConfig.fromJson(Map<String, dynamic> json) => _$AccessibilityConfigFromJson(json);
  Map<String, dynamic> toJson() => _$AccessibilityConfigToJson(this);

  factory AccessibilityConfig.defaultConfig() {
    return const AccessibilityConfig(
      enableScreenReader: true,
      enableVoiceGuidance: false,
      reduceAnimations: false,
      increasedContrast: false,
      largerTouchTargets: false,
      minimumTouchSize: 44.0, // Following iOS HIG and Material guidelines
      enableSemanticLabels: true,
      enableHapticFeedback: true,
    );
  }

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

/// FeatureFlags control which features are available in different app versions
/// This is crucial for white-labeling where different clients may have different feature sets
@JsonSerializable()
class FeatureFlags {
  final bool enableUserProfiles;
  final bool enableItemReordering;
  final bool enableColorCustomization;
  final bool enableDataExport;
  final bool enableOfflineMode;
  final bool enableAnalytics;
  final bool enablePushNotifications;
  final Map<String, bool> customFeatures; // For client-specific features

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

  factory FeatureFlags.fromJson(Map<String, dynamic> json) => _$FeatureFlagsFromJson(json);
  Map<String, dynamic> toJson() => _$FeatureFlagsToJson(this);

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
      enableColorCustomization: enableColorCustomization ?? this.enableColorCustomization,
      enableDataExport: enableDataExport ?? this.enableDataExport,
      enableOfflineMode: enableOfflineMode ?? this.enableOfflineMode,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      enablePushNotifications: enablePushNotifications ?? this.enablePushNotifications,
      customFeatures: customFeatures ?? this.customFeatures,
    );
  }
}

/// LocalizationConfig manages language and regional preferences
@JsonSerializable()
class LocalizationConfig {
  final String languageCode;      // 'en', 'es', 'fr', etc.
  final String? countryCode;      // 'US', 'MX', 'CA', etc. (optional)
  final bool useDeviceLocale;     // Whether to follow device language settings
  final String dateFormat;        // How to format dates
  final String timeFormat;        // 12 or 24 hour format
  final String numberFormat;      // Number formatting preferences

  const LocalizationConfig({
    required this.languageCode,
    this.countryCode,
    required this.useDeviceLocale,
    required this.dateFormat,
    required this.timeFormat,
    required this.numberFormat,
  });

  factory LocalizationConfig.fromJson(Map<String, dynamic> json) => _$LocalizationConfigFromJson(json);
  Map<String, dynamic> toJson() => _$LocalizationConfigToJson(this);

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

  /// Creates a Locale object for Flutter's localization system
  Locale get locale => Locale(languageCode, countryCode);

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