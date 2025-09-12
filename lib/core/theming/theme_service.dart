import 'package:flutter/material.dart';
import 'package:core_design_system/core_design_system.dart' as ds;
import '../configuration/app_config.dart';

/// Thin adapter to feed AppConfig into DS ThemeService
abstract class ThemeService {
  ThemeData buildTheme(AppConfig config, Brightness platformBrightness);
  TextTheme buildTextTheme(double textScaleFactor);
}

class DefaultThemeService implements ThemeService {
  final ds.ThemeService _ds;
  DefaultThemeService({ds.ThemeService? designSystem}) : _ds = designSystem ?? const ds.DefaultThemeService();

  @override
  ThemeData buildTheme(AppConfig config, Brightness platformBrightness) {
    return _ds.buildTheme(
      platformBrightness: platformBrightness,
      themeMode: config.theme.themeMode,
      textScaleFactor: config.theme.textScaleFactor,
      visualDensity: config.theme.visualDensity,
      useMaterial3: config.theme.useMaterial3,
      brandPrimary: config.brand.primaryColor,
      brandSecondary: config.brand.secondaryColor,
      brandAccent: config.brand.accentColor,
    );
  }

  @override
  TextTheme buildTextTheme(double textScaleFactor) => _ds.buildTextTheme(textScaleFactor);
}
