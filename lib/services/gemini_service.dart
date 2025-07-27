import 'package:google_generative_ai/google_generative_ai.dart';
import '../services/api_key_database.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';


class GeminiService {
  static ChatSession? _chat;
  static String? _lastLocaleCode;

  /// Inicia la sesión de chat con historial y primer mensaje forzado por idioma
  static Future<void> _initSession(Locale locale) async {
    if (_chat != null && _lastLocaleCode == locale.languageCode) return;

    final activeKey = await ApiKeyDatabase.getActiveKey();
    if (activeKey == null) throw Exception("No hay API Key activa.");

    final model = GenerativeModel(model: 'gemini-pro', apiKey: activeKey.key);

    final prompt = locale.languageCode == 'en'
        ? "Always reply in English, never use Spanish."
        : "Responde siempre en español, nunca uses inglés.";

    _chat = model.startChat(history: [Content.text(prompt)]);
    _lastLocaleCode = locale.languageCode;
  }

  static Future<String> chat(String userMessage, BuildContext context) async {
    final locale = Localizations.localeOf(context);
    final localizations = AppLocalizations.of(context)!;

    try {
      await _initSession(locale);
      final response = await _chat!.sendMessage(Content.text(userMessage));
      return response.text ?? localizations.errorNoResponse;
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('API Key')) {
        return localizations.errorNoApiKey;
      }
      return localizations.errorUnexpected(msg);
    }
  }

  /// Reinicia el historial
  static void reset() {
    _chat = null;
    _lastLocaleCode = null;
  }
}
