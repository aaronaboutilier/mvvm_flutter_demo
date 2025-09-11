import 'package:flutter/material.dart';
import '../configuration/app_config.dart';

abstract class ThemeService {
  ThemeData buildTheme(AppConfig config, Brightness platformBrightness);
  TextTheme buildTextTheme(double textScaleFactor);
}

class DefaultThemeService implements ThemeService {
  @override
  ThemeData buildTheme(AppConfig config, Brightness platformBrightness) {
    final isDark = config.theme.themeMode == ThemeMode.dark ||
        (config.theme.themeMode == ThemeMode.system && platformBrightness == Brightness.dark);
  final base = isDark
    ? ThemeData.dark(useMaterial3: config.theme.useMaterial3)
    : ThemeData.light(useMaterial3: config.theme.useMaterial3);
    final colorScheme = base.colorScheme.copyWith(
      primary: config.brand.primaryColor,
      secondary: config.brand.secondaryColor,
      tertiary: config.brand.accentColor,
    );
  return base.copyWith(
      colorScheme: colorScheme,
      visualDensity: config.theme.visualDensity,
      textTheme: buildTextTheme(config.theme.textScaleFactor),
    );
  }

  @override
  TextTheme buildTextTheme(double textScaleFactor) {
    return ThemeData.light().textTheme.apply(
          fontSizeFactor: textScaleFactor.clamp(0.8, 2.0),
        );
  }
}
