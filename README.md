# Gestor de API Keys para Gemini - Aplicación Flutter

## Características
- Gestión de hasta 10 API Keys de Gemini (crear, editar, eliminar, activar)
- Integración con el modelo Gemini 2.5 Flash
- Alternar entre tema claro/oscuro
- Soporte para múltiples idiomas (inglés/español)
- Almacenamiento local seguro para las API Keys

## Cómo obtener API Keys
1. Visita Google AI Studio: https://aistudio.google.com/
2. Inicia sesión con tu cuenta de Google
3. Haz clic en "Get API Key" en la esquina superior derecha
4. Copia tu clave generada (formato: AIzaSy...)

## Detalles Técnicos
- Modelo utilizado: gemini-2.5-flash
- Gestión de estado: Provider
- Internacionalización: flutter_localizations
- Almacenamiento: shared_preferences y sqflite

## Configuración para Desarrollo
1. Clona el repositorio
2. Ejecuta `flutter pub get`