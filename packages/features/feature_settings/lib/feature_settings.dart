// Public API for the Settings feature
export 'src/application/usecases/settings_usecases.dart';
export 'src/di.dart' show registerFeatureSettings;
export 'src/domain/entities/settings_config.dart';
export 'src/domain/repositories/settings_repository.dart';
export 'src/domain/value_objects/language_code.dart';
export 'src/domain/value_objects/text_scale.dart';
export 'src/domain/value_objects/theme_preference.dart';
export 'src/presentation/viewmodels/settings_view_state.dart';
export 'src/presentation/viewmodels/settings_viewmodel.dart';
export 'src/presentation/views/settings_overlay.dart' show showSettingsOverlay;
export 'src/presentation/views/settings_page.dart';
export 'src/presentation/widgets/settings_body.dart' show SettingsBody;
export 'src/presentation/widgets/settings_button.dart' show SettingsButton;
