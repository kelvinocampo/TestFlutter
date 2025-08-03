// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'IA Movil';

  @override
  String get title => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get hintMessage => 'Escribe un mensaje...';

  @override
  String get settings => 'Configuración';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String get spanish => 'Español';

  @override
  String get english => 'Inglés';

  @override
  String get noMessages => 'No hay mensajes aún';

  @override
  String get send => 'Enviar';

  @override
  String get edit => 'Editar';

  @override
  String get active => 'Activar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit_apikey => 'Editar Api Key';

  @override
  String get new_apikey => 'Nueva Api Key';

  @override
  String get apikey_name => 'Nombre Unico';

  @override
  String get exceeded_apikey_limit => 'Límite de 10 API Keys alcanzado';

  @override
  String get add_apikey => 'Agregar API Key';

  @override
  String get apikey_name_required => 'El nombre de la API Key es obligatorio';

  @override
  String get apikey_required => 'La API Key es obligatoria';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get restart_chat => 'Reiniciar Chat';

  @override
  String get errorNoApiKey => 'No hay API Key activa.';

  @override
  String get errorNoResponse => 'La IA no respondió.';

  @override
  String errorUnexpected(Object message) {
    return 'Error: $message';
  }

  @override
  String get close => 'Cerrar';

  @override
  String get error => 'Error';

  @override
  String get confirm => 'Confirmar';

  @override
  String get confirm_edit_title => '¿Editar API Key?';

  @override
  String confirm_edit_message(Object name) {
    return '¿Deseas editar la clave $name?';
  }

  @override
  String get confirm_delete_title => '¿Eliminar API Key?';

  @override
  String confirm_delete_message(Object name) {
    return '¿Seguro que deseas eliminar $name?';
  }

  @override
  String get limit_apikeys => 'No puedes agregar más de 10 claves.';

  @override
  String get name_exists => 'El nombre ya existe.';

  @override
  String get key_exists => 'La clave ya existe.';

  @override
  String get errorNoInternet => 'Sin conexión a internet.';
}
