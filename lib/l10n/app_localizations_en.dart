// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ChatGPT Style';

  @override
  String get title => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get hintMessage => 'Type a message...';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get spanish => 'Spanish';

  @override
  String get english => 'English';

  @override
  String get noMessages => 'No messages yet';

  @override
  String get send => 'Send';

  @override
  String get edit => 'Edit';

  @override
  String get active => 'Active';

  @override
  String get delete => 'Delete';

  @override
  String get edit_apikey => 'Edit Api Key';

  @override
  String get new_apikey => 'New Api Key';

  @override
  String get apikey_name => 'Unique Name';

  @override
  String get exceeded_apikey_limit => 'Exceeded 10 API Keys limit';

  @override
  String get add_apikey => 'Add API Key';

  @override
  String get apikey_name_required => 'API Key name is required';

  @override
  String get apikey_required => 'API Key is required';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get restart_chat => 'Restart Chat';

  @override
  String get errorNoApiKey => 'No active API key.';

  @override
  String get errorNoResponse => 'Gemini didn\'t respond.';

  @override
  String errorUnexpected(Object message) {
    return 'Error: $message';
  }

  @override
  String get close => 'Close';

  @override
  String get error => 'Error';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirm_edit_title => 'Edit API Key?';

  @override
  String confirm_edit_message(Object name) {
    return 'Do you want to edit the key $name?';
  }

  @override
  String get confirm_delete_title => 'Delete API Key?';

  @override
  String confirm_delete_message(Object name) {
    return 'Are you sure you want to delete $name?';
  }
}
