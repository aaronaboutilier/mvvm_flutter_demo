import '../../../../models/app_config.dart';
import '../../../../core/result/result.dart';
import '../value_objects/text_scale.dart';
import '../value_objects/language_code.dart';
import '../value_objects/theme_mode_vo.dart';

abstract class SettingsRepository {
  AppConfig get currentConfig;

  Future<Result<void>> updateThemeMode(ThemeModeVO newThemeMode);
  Future<Result<void>> updateTextScaleFactor(TextScale newScaleFactor);

  Future<Result<void>> updateReduceAnimations(bool reduceAnimations);
  Future<Result<void>> updateHighContrast(bool highContrast);
  Future<Result<void>> updateLargerTouchTargets(bool largerTouchTargets);
  Future<Result<void>> updateVoiceGuidance(bool enableVoiceGuidance);
  Future<Result<void>> updateHapticFeedback(bool enableHapticFeedback);

  Future<Result<void>> updateUseDeviceLocale(bool useDeviceLocale);
  Future<Result<void>> updateLanguageCode(LanguageCode languageCode);

  Future<Result<String>> exportConfiguration();
  Future<Result<void>> resetToDefaults();

  bool isFeatureEnabled(String featureName);
}
