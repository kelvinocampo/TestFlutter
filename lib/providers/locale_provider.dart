import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../services/gemini_service.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('es'); // Idioma por defecto

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocaleFromPrefs();
  }

  /// Carga el idioma guardado desde SharedPreferences
  Future<void> _loadLocaleFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString('localeCode');

    if (localeCode != null && localeCode.isNotEmpty) {
      _locale = Locale(localeCode);
      notifyListeners();
    }
  }

  /// Cambia el idioma y lo guarda en SharedPreferences
  Future<void> setLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('localeCode', newLocale.languageCode);
    _locale = newLocale;
    // GeminiService.reset();
    notifyListeners();
  }
}
