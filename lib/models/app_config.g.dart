// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
  brand: BrandConfig.fromJson(json['brand'] as Map<String, dynamic>),
  theme: ThemeConfig.fromJson(json['theme'] as Map<String, dynamic>),
  accessibility: AccessibilityConfig.fromJson(
    json['accessibility'] as Map<String, dynamic>,
  ),
  features: FeatureFlags.fromJson(json['features'] as Map<String, dynamic>),
  localization: LocalizationConfig.fromJson(
    json['localization'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
  'brand': instance.brand,
  'theme': instance.theme,
  'accessibility': instance.accessibility,
  'features': instance.features,
  'localization': instance.localization,
};

BrandConfig _$BrandConfigFromJson(Map<String, dynamic> json) => BrandConfig(
  appName: json['appName'] as String,
  logoPath: json['logoPath'] as String,
  primaryColorHex: json['primaryColorHex'] as String,
  secondaryColorHex: json['secondaryColorHex'] as String,
  accentColorHex: json['accentColorHex'] as String,
  fontFamily: json['fontFamily'] as String,
  websiteUrl: json['websiteUrl'] as String,
  supportEmail: json['supportEmail'] as String,
  customAssets: Map<String, String>.from(json['customAssets'] as Map),
);

Map<String, dynamic> _$BrandConfigToJson(BrandConfig instance) =>
    <String, dynamic>{
      'appName': instance.appName,
      'logoPath': instance.logoPath,
      'primaryColorHex': instance.primaryColorHex,
      'secondaryColorHex': instance.secondaryColorHex,
      'accentColorHex': instance.accentColorHex,
      'fontFamily': instance.fontFamily,
      'websiteUrl': instance.websiteUrl,
      'supportEmail': instance.supportEmail,
      'customAssets': instance.customAssets,
    };

ThemeConfig _$ThemeConfigFromJson(Map<String, dynamic> json) => ThemeConfig(
  themeMode: $enumDecode(_$ThemeModeEnumMap, json['themeMode']),
  textScaleFactor: (json['textScaleFactor'] as num).toDouble(),
  visualDensity: const VisualDensityConverter().fromJson(
    json['visualDensity'] as String,
  ),
  useSystemAccentColor: json['useSystemAccentColor'] as bool,
  useMaterial3: json['useMaterial3'] as bool,
  customColors: Map<String, String>.from(json['customColors'] as Map),
);

Map<String, dynamic> _$ThemeConfigToJson(ThemeConfig instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'textScaleFactor': instance.textScaleFactor,
      'visualDensity': const VisualDensityConverter().toJson(
        instance.visualDensity,
      ),
      'useSystemAccentColor': instance.useSystemAccentColor,
      'useMaterial3': instance.useMaterial3,
      'customColors': instance.customColors,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

AccessibilityConfig _$AccessibilityConfigFromJson(Map<String, dynamic> json) =>
    AccessibilityConfig(
      enableScreenReader: json['enableScreenReader'] as bool,
      enableVoiceGuidance: json['enableVoiceGuidance'] as bool,
      reduceAnimations: json['reduceAnimations'] as bool,
      increasedContrast: json['increasedContrast'] as bool,
      largerTouchTargets: json['largerTouchTargets'] as bool,
      minimumTouchSize: (json['minimumTouchSize'] as num).toDouble(),
      enableSemanticLabels: json['enableSemanticLabels'] as bool,
      enableHapticFeedback: json['enableHapticFeedback'] as bool,
    );

Map<String, dynamic> _$AccessibilityConfigToJson(
  AccessibilityConfig instance,
) => <String, dynamic>{
  'enableScreenReader': instance.enableScreenReader,
  'enableVoiceGuidance': instance.enableVoiceGuidance,
  'reduceAnimations': instance.reduceAnimations,
  'increasedContrast': instance.increasedContrast,
  'largerTouchTargets': instance.largerTouchTargets,
  'minimumTouchSize': instance.minimumTouchSize,
  'enableSemanticLabels': instance.enableSemanticLabels,
  'enableHapticFeedback': instance.enableHapticFeedback,
};

FeatureFlags _$FeatureFlagsFromJson(Map<String, dynamic> json) => FeatureFlags(
  enableUserProfiles: json['enableUserProfiles'] as bool,
  enableItemReordering: json['enableItemReordering'] as bool,
  enableColorCustomization: json['enableColorCustomization'] as bool,
  enableDataExport: json['enableDataExport'] as bool,
  enableOfflineMode: json['enableOfflineMode'] as bool,
  enableAnalytics: json['enableAnalytics'] as bool,
  enablePushNotifications: json['enablePushNotifications'] as bool,
  customFeatures: Map<String, bool>.from(json['customFeatures'] as Map),
);

Map<String, dynamic> _$FeatureFlagsToJson(FeatureFlags instance) =>
    <String, dynamic>{
      'enableUserProfiles': instance.enableUserProfiles,
      'enableItemReordering': instance.enableItemReordering,
      'enableColorCustomization': instance.enableColorCustomization,
      'enableDataExport': instance.enableDataExport,
      'enableOfflineMode': instance.enableOfflineMode,
      'enableAnalytics': instance.enableAnalytics,
      'enablePushNotifications': instance.enablePushNotifications,
      'customFeatures': instance.customFeatures,
    };

LocalizationConfig _$LocalizationConfigFromJson(Map<String, dynamic> json) =>
    LocalizationConfig(
      languageCode: json['languageCode'] as String,
      countryCode: json['countryCode'] as String?,
      useDeviceLocale: json['useDeviceLocale'] as bool,
      dateFormat: json['dateFormat'] as String,
      timeFormat: json['timeFormat'] as String,
      numberFormat: json['numberFormat'] as String,
    );

Map<String, dynamic> _$LocalizationConfigToJson(LocalizationConfig instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'countryCode': instance.countryCode,
      'useDeviceLocale': instance.useDeviceLocale,
      'dateFormat': instance.dateFormat,
      'timeFormat': instance.timeFormat,
      'numberFormat': instance.numberFormat,
    };
