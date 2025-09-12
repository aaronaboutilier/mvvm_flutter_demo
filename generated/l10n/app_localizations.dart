import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'MVVM Demo'**
  String get appTitle;

  /// Title for the home screen
  ///
  /// In en, this message translates to:
  /// **'MVVM Demo - Home'**
  String get homeTitle;

  /// Title for the details screen
  ///
  /// In en, this message translates to:
  /// **'MVVM Demo - Details'**
  String get detailsTitle;

  /// Welcome message for returning users
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {userName}!'**
  String welcomeBack(String userName);

  /// Welcome message for guests
  ///
  /// In en, this message translates to:
  /// **'Welcome, Guest!'**
  String get welcomeGuest;

  /// Message shown while loading user data
  ///
  /// In en, this message translates to:
  /// **'Loading user information...'**
  String get loadingUser;

  /// Header for user information section
  ///
  /// In en, this message translates to:
  /// **'User Information:'**
  String get userInformation;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String userId(String id);

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'Name: {name}'**
  String userName(String name);

  /// No description provided for @userEmail.
  ///
  /// In en, this message translates to:
  /// **'Email: {email}'**
  String userEmail(String email);

  /// Shows how many times the button was clicked
  ///
  /// In en, this message translates to:
  /// **'Button clicked {count} times'**
  String buttonClickedTimes(int count);

  /// Text for the clickable button
  ///
  /// In en, this message translates to:
  /// **'Click Me!'**
  String get clickMe;

  /// Header for navigation section
  ///
  /// In en, this message translates to:
  /// **'Navigation Example'**
  String get navigationExample;

  /// Button text to navigate to details screen
  ///
  /// In en, this message translates to:
  /// **'Go to Details'**
  String get goToDetails;

  /// Button text to navigate back to home
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// Header for color selection section
  ///
  /// In en, this message translates to:
  /// **'Choose Your Theme Color:'**
  String get chooseThemeColor;

  /// Header for add item section
  ///
  /// In en, this message translates to:
  /// **'Add New Item:'**
  String get addNewItem;

  /// Placeholder text for item name input
  ///
  /// In en, this message translates to:
  /// **'Enter item name...'**
  String get enterItemName;

  /// Header for items list with count
  ///
  /// In en, this message translates to:
  /// **'Your Items ({count}):'**
  String yourItems(int count);

  /// Message when no items are present
  ///
  /// In en, this message translates to:
  /// **'No items yet'**
  String get noItemsYet;

  /// Instruction message when list is empty
  ///
  /// In en, this message translates to:
  /// **'Add your first item above to get started!'**
  String get addFirstItem;

  /// Summary text showing item count and theme
  ///
  /// In en, this message translates to:
  /// **'You have {count} items in {color} theme'**
  String itemsSummary(int count, String color);

  /// Summary when no items exist
  ///
  /// In en, this message translates to:
  /// **'No items yet. Add some to get started!'**
  String get noItemsSummary;

  /// Button text and dialog title for clearing all items
  ///
  /// In en, this message translates to:
  /// **'Clear All Items'**
  String get clearAllItems;

  /// Confirmation message for clearing all items
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all items?'**
  String get clearAllConfirmation;

  /// Generic cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirmation button for clearing items
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// Button text for retrying an operation
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Tooltip for clear user button
  ///
  /// In en, this message translates to:
  /// **'Clear User'**
  String get clearUser;

  /// Header for navigation section
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigation;

  /// Title for 404 error page
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get pageNotFound;

  /// Error message for 404 page
  ///
  /// In en, this message translates to:
  /// **'Oops! Page not found.'**
  String get pageNotFoundMessage;

  /// Button text to return to home page
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get goHome;

  /// Name of red color
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get colorRed;

  /// Name of blue color
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get colorBlue;

  /// Name of green color
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get colorGreen;

  /// Name of yellow color
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get colorYellow;

  /// Name of purple color
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get colorPurple;

  /// Name of orange color
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get colorOrange;

  /// Title for settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Header for theme settings section
  ///
  /// In en, this message translates to:
  /// **'Theme & Appearance'**
  String get themeSettings;

  /// Label for theme mode selection
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// Label for text size setting
  ///
  /// In en, this message translates to:
  /// **'Text Size'**
  String get textSize;

  /// Small text size indicator
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get textSizeSmall;

  /// Large text size indicator
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get textSizeLarge;

  /// Header for accessibility settings section
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get accessibilitySettings;

  /// Label for reduce animations setting
  ///
  /// In en, this message translates to:
  /// **'Reduce Animations'**
  String get reduceAnimations;

  /// Description for reduce animations setting
  ///
  /// In en, this message translates to:
  /// **'Minimize motion for better accessibility'**
  String get reduceAnimationsDescription;

  /// Label for high contrast setting
  ///
  /// In en, this message translates to:
  /// **'High Contrast'**
  String get highContrast;

  /// Description for high contrast setting
  ///
  /// In en, this message translates to:
  /// **'Increase contrast for better visibility'**
  String get highContrastDescription;

  /// Label for larger touch targets setting
  ///
  /// In en, this message translates to:
  /// **'Larger Touch Targets'**
  String get largerTouchTargets;

  /// Description for larger touch targets setting
  ///
  /// In en, this message translates to:
  /// **'Make buttons and controls easier to tap'**
  String get largerTouchTargetsDescription;

  /// Label for voice guidance setting
  ///
  /// In en, this message translates to:
  /// **'Voice Guidance'**
  String get voiceGuidance;

  /// Description for voice guidance setting
  ///
  /// In en, this message translates to:
  /// **'Enable text-to-speech for interface elements'**
  String get voiceGuidanceDescription;

  /// Label for haptic feedback setting
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get hapticFeedback;

  /// Description for haptic feedback setting
  ///
  /// In en, this message translates to:
  /// **'Feel vibrations when interacting with the app'**
  String get hapticFeedbackDescription;

  /// Header for language settings section
  ///
  /// In en, this message translates to:
  /// **'Language & Region'**
  String get languageSettings;

  /// Label for device language setting
  ///
  /// In en, this message translates to:
  /// **'Use Device Language'**
  String get useDeviceLanguage;

  /// Description for device language setting
  ///
  /// In en, this message translates to:
  /// **'Follow your device\'s language setting'**
  String get useDeviceLanguageDescription;

  /// Label for manual language selection
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Generic language label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Header for advanced settings section
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advancedSettings;

  /// Label for export settings option
  ///
  /// In en, this message translates to:
  /// **'Export Settings'**
  String get exportSettings;

  /// Description for export settings option
  ///
  /// In en, this message translates to:
  /// **'Save your current configuration to a file'**
  String get exportSettingsDescription;

  /// Label for reset settings option
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get resetToDefaults;

  /// Description for reset settings option
  ///
  /// In en, this message translates to:
  /// **'Restore all settings to their original values'**
  String get resetToDefaultsDescription;

  /// Confirmation message for resetting settings
  ///
  /// In en, this message translates to:
  /// **'This will reset all your preferences to default values. This action cannot be undone.'**
  String get resetConfirmation;

  /// Confirmation button for reset action
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Header for app information section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutApp;

  /// Label for app name
  ///
  /// In en, this message translates to:
  /// **'App Name'**
  String get appName;

  /// Label for app version
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Label for website
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// Label for support contact
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
