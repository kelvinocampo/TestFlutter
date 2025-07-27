import 'package:google_generative_ai/google_generative_ai.dart';
import 'api_key_database.dart'; // Ajusta el path

class GeminiService {
  static Future<String> chat(String userMessage) async {
    final activeKey = await ApiKeyDatabase.getActiveKey();
    if (activeKey == null) {
      return "❌ No hay API Key activa.";
    }

    final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: activeKey.key,
    );

    try {
      final response = await model.generateContent([
        Content.text(userMessage),
      ]);

      return response.text ?? "⚠️ No hubo respuesta.";
    } catch (e) {
      return "❌ Error: ${e.toString()}";
    }
  }
}
