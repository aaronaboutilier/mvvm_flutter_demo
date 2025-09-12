import 'package:flutter/material.dart';

import '../tokens/colors.dart';

/// A DS-driven theme service that builds ThemeData from tokens and app inputs.
abstract class ThemeService {
  ThemeData buildTheme({
    required Brightness platformBrightness,
    ThemeMode themeMode = ThemeMode.system,
    double textScaleFactor = 1.0,
    VisualDensity visualDensity = VisualDensity.standard,
    bool useMaterial3 = true,
    Color? brandPrimary,
    Color? brandSecondary,
    Color? brandAccent,
  });

  TextTheme buildTextTheme(double textScaleFactor);
}

class DefaultThemeService implements ThemeService {
  const DefaultThemeService();

  @override
  ThemeData buildTheme({
    required Brightness platformBrightness,
    ThemeMode themeMode = ThemeMode.system,
    double textScaleFactor = 1.0,
    VisualDensity visualDensity = VisualDensity.standard,
    bool useMaterial3 = true,
    Color? brandPrimary,
    Color? brandSecondary,
    Color? brandAccent,
  }) {
    final isDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && platformBrightness == Brightness.dark);

    final base = isDark
        ? ThemeData.dark(useMaterial3: useMaterial3)
        : ThemeData.light(useMaterial3: useMaterial3);

    final colorScheme = base.colorScheme.copyWith(
      primary: brandPrimary ?? AppColors.primary,
      secondary: brandSecondary ?? AppColors.secondary,
      tertiary: brandAccent ?? AppColors.success,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      visualDensity: visualDensity,
      textTheme: buildTextTheme(textScaleFactor),
    );
  }

  @override
  TextTheme buildTextTheme(double textScaleFactor) {
    return ThemeData.light().textTheme.apply(
          fontSizeFactor: textScaleFactor.clamp(0.8, 2.0),
        );
  }
}
