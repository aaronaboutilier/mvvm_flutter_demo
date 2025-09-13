// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MVVM Demo';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get close => 'Close';

  @override
  String get theme => 'Theme';

  @override
  String get themeMode => 'Theme mode';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get textSize => 'Text size';

  @override
  String get small => 'Small';

  @override
  String get large => 'Large';

  @override
  String get accessibility => 'Accessibility';

  @override
  String get reduceAnimations => 'Reduce animations';

  @override
  String get highContrast => 'High contrast';

  @override
  String get largerTouchTargets => 'Larger touch targets';

  @override
  String get voiceGuidance => 'Voice guidance';

  @override
  String get hapticFeedback => 'Haptic feedback';

  @override
  String get language => 'Language';

  @override
  String get useDeviceLanguage => 'Use device language';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get exportConfiguration => 'Export configuration';

  @override
  String get resetToDefaults => 'Reset to defaults';

  @override
  String get advanced => 'Advanced';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get products => 'Products';

  @override
  String get detailsTitle => 'MVVM Demo - Details';

  @override
  String get retry => 'Retry';

  @override
  String get clickMe => 'Click Me!';

  @override
  String get goToDetails => 'Go to Details';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get navigation => 'Navigation';

  @override
  String get navigationExample => 'Navigation Example';

  @override
  String get loadingUserInformation => 'Loading user information...';

  @override
  String get userInformation => 'User Information:';

  @override
  String get clearUser => 'Clear User';

  @override
  String buttonClickedTimes(Object count) {
    return 'Button clicked $count times';
  }

  @override
  String get chooseThemeColor => 'Choose Your Theme Color:';

  @override
  String get addNewItem => 'Add New Item:';

  @override
  String get enterItemNameHint => 'Enter item name...';

  @override
  String get noItemsYet => 'No items yet';

  @override
  String get addFirstItemHelp => 'Add your first item above to get started!';

  @override
  String itemsCount(Object count) {
    return 'Items: $count';
  }

  @override
  String yourItemsCount(Object count) {
    return 'Your Items ($count):';
  }

  @override
  String get clearAllItems => 'Clear All Items';

  @override
  String get clearAllConfirmation =>
      'Are you sure you want to remove all items?';

  @override
  String get cancel => 'Cancel';

  @override
  String get clearAll => 'Clear All';
}
