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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Mobile'**
  String get appTitle;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get title;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @hintMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get hintMessage;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @noMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessages;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit_apikey.
  ///
  /// In en, this message translates to:
  /// **'Edit Api Key'**
  String get edit_apikey;

  /// No description provided for @new_apikey.
  ///
  /// In en, this message translates to:
  /// **'New Api Key'**
  String get new_apikey;

  /// No description provided for @apikey_name.
  ///
  /// In en, this message translates to:
  /// **'Unique Name'**
  String get apikey_name;

  /// No description provided for @exceeded_apikey_limit.
  ///
  /// In en, this message translates to:
  /// **'Exceeded 10 API Keys limit'**
  String get exceeded_apikey_limit;

  /// No description provided for @add_apikey.
  ///
  /// In en, this message translates to:
  /// **'Add API Key'**
  String get add_apikey;

  /// No description provided for @apikey_name_required.
  ///
  /// In en, this message translates to:
  /// **'API Key name is required'**
  String get apikey_name_required;

  /// No description provided for @apikey_required.
  ///
  /// In en, this message translates to:
  /// **'API Key is required'**
  String get apikey_required;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @restart_chat.
  ///
  /// In en, this message translates to:
  /// **'Restart Chat'**
  String get restart_chat;

  /// No description provided for @errorNoApiKey.
  ///
  /// In en, this message translates to:
  /// **'No active API key.'**
  String get errorNoApiKey;

  /// No description provided for @errorNoResponse.
  ///
  /// In en, this message translates to:
  /// **'The AI didn\'t respond.'**
  String get errorNoResponse;

  /// Displayed when an unexpected error occurs
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorUnexpected(Object message);

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirm_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit API Key?'**
  String get confirm_edit_title;

  /// Displayed when confirming the edit of an API Key
  ///
  /// In en, this message translates to:
  /// **'Do you want to edit the key {name}?'**
  String confirm_edit_message(Object name);

  /// No description provided for @confirm_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete API Key?'**
  String get confirm_delete_title;

  /// Displayed when confirming the deletion of an API Key
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String confirm_delete_message(Object name);

  /// No description provided for @limit_apikeys.
  ///
  /// In en, this message translates to:
  /// **'You cannot add more than 10 keys.'**
  String get limit_apikeys;

  /// No description provided for @name_exists.
  ///
  /// In en, this message translates to:
  /// **'The name already exists.'**
  String get name_exists;

  /// No description provided for @key_exists.
  ///
  /// In en, this message translates to:
  /// **'The key already exists.'**
  String get key_exists;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get errorNoInternet;
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
