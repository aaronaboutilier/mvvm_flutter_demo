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
  String get homeTitle => 'MVVM Demo - Home';

  @override
  String get detailsTitle => 'MVVM Demo - Details';

  @override
  String welcomeBack(String userName) {
    return 'Welcome back, $userName!';
  }

  @override
  String get welcomeGuest => 'Welcome, Guest!';

  @override
  String get loadingUser => 'Loading user information...';

  @override
  String get userInformation => 'User Information:';

  @override
  String userId(String id) {
    return 'ID: $id';
  }

  @override
  String userName(String name) {
    return 'Name: $name';
  }

  @override
  String userEmail(String email) {
    return 'Email: $email';
  }

  @override
  String buttonClickedTimes(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Button clicked $countString times';
  }

  @override
  String get clickMe => 'Click Me!';

  @override
  String get navigationExample => 'Navigation Example';

  @override
  String get goToDetails => 'Go to Details';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get chooseThemeColor => 'Choose Your Theme Color:';

  @override
  String get addNewItem => 'Add New Item:';

  @override
  String get enterItemName => 'Enter item name...';

  @override
  String yourItems(int count) {
    return 'Your Items ($count):';
  }

  @override
  String get noItemsYet => 'No items yet';

  @override
  String get addFirstItem => 'Add your first item above to get started!';

  @override
  String itemsSummary(int count, String color) {
    return 'You have $count items in $color theme';
  }

  @override
  String get noItemsSummary => 'No items yet. Add some to get started!';

  @override
  String get clearAllItems => 'Clear All Items';

  @override
  String get clearAllConfirmation =>
      'Are you sure you want to remove all items?';

  @override
  String get cancel => 'Cancel';

  @override
  String get clearAll => 'Clear All';

  @override
  String get retry => 'Retry';

  @override
  String get clearUser => 'Clear User';

  @override
  String get navigation => 'Navigation';

  @override
  String get pageNotFound => 'Page Not Found';

  @override
  String get pageNotFoundMessage => 'Oops! Page not found.';

  @override
  String get goHome => 'Go Home';

  @override
  String get colorRed => 'Red';

  @override
  String get colorBlue => 'Blue';

  @override
  String get colorGreen => 'Green';

  @override
  String get colorYellow => 'Yellow';

  @override
  String get colorPurple => 'Purple';

  @override
  String get colorOrange => 'Orange';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeSettings => 'Theme & Appearance';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get systemTheme => 'System';

  @override
  String get textSize => 'Text Size';

  @override
  String get textSizeSmall => 'A';

  @override
  String get textSizeLarge => 'A';

  @override
  String get accessibilitySettings => 'Accessibility';

  @override
  String get reduceAnimations => 'Reduce Animations';

  @override
  String get reduceAnimationsDescription =>
      'Minimize motion for better accessibility';

  @override
  String get highContrast => 'High Contrast';

  @override
  String get highContrastDescription =>
      'Increase contrast for better visibility';

  @override
  String get largerTouchTargets => 'Larger Touch Targets';

  @override
  String get largerTouchTargetsDescription =>
      'Make buttons and controls easier to tap';

  @override
  String get voiceGuidance => 'Voice Guidance';

  @override
  String get voiceGuidanceDescription =>
      'Enable text-to-speech for interface elements';

  @override
  String get hapticFeedback => 'Haptic Feedback';

  @override
  String get hapticFeedbackDescription =>
      'Feel vibrations when interacting with the app';

  @override
  String get languageSettings => 'Language & Region';

  @override
  String get useDeviceLanguage => 'Use Device Language';

  @override
  String get useDeviceLanguageDescription =>
      'Follow your device\'s language setting';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get language => 'Language';

  @override
  String get advancedSettings => 'Advanced';

  @override
  String get exportSettings => 'Export Settings';

  @override
  String get exportSettingsDescription =>
      'Save your current configuration to a file';

  @override
  String get resetToDefaults => 'Reset to Defaults';

  @override
  String get resetToDefaultsDescription =>
      'Restore all settings to their original values';

  @override
  String get resetConfirmation =>
      'This will reset all your preferences to default values. This action cannot be undone.';

  @override
  String get reset => 'Reset';

  @override
  String get aboutApp => 'About';

  @override
  String get appName => 'App Name';

  @override
  String get version => 'Version';

  @override
  String get website => 'Website';

  @override
  String get support => 'Support';
}
