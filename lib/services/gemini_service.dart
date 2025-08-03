import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../services/api_key_database.dart';
import '../l10n/app_localizations.dart';

class GeminiService {
  static ChatSession? _chat;
  static String? _lastApiKey;
  static String? _lastLocaleCode;

  /// Verifica conexión a internet
  static Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  /// Inicia la sesión de chat siempre que cambie idioma o API Key
  static Future<void> _initSession(Locale locale) async {
    final activeKey = await ApiKeyDatabase.getActiveKey();
    if (activeKey == null) throw Exception("API Key");

    if (_chat != null &&
        _lastLocaleCode == locale.languageCode &&
        _lastApiKey == activeKey.key) {
      return;
    }

    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: activeKey.key,
    );

    final prompt = locale.languageCode == 'en'
        ? "Always reply in English, never use Spanish."
        : "Responde siempre en español, nunca uses inglés.";

    _chat = model.startChat(history: [Content.text(prompt)]);
    _lastLocaleCode = locale.languageCode;
    _lastApiKey = activeKey.key;
  }

  /// Envia mensaje al modelo Gemini
  static Future<String> chat(String userMessage, BuildContext context) async {
    final locale = Localizations.localeOf(context);
    final localizations = AppLocalizations.of(context)!;

    final errorNoInternet = localizations.errorNoInternet;
    final errorNoApiKey = localizations.errorNoApiKey;
    final errorNoResponse = localizations.errorNoResponse;
    final Function(String) errorUnexpected = localizations.errorUnexpected;

    try {
      if (!await _hasInternet()) {
        return errorNoInternet;
      }

      await _initSession(locale);
      final response = await _chat!.sendMessage(Content.text(userMessage));
      return response.text ?? errorNoResponse;
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('API Key')) {
        return errorNoApiKey;
      }
      return errorUnexpected(msg);
    }
  }

  /// Reinicia el historial y API
  static void reset() {
    _chat = null;
    _lastApiKey = null;
    _lastLocaleCode = null;
  }
}
