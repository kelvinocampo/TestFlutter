import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';
import '../models/api_key_model.dart';
import '../providers/api_key_provider.dart';
import '../l10n/app_localizations.dart';
import '../components/api_key_form.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ApiKeyProvider>().loadKeys();
  }

  void _confirmDelete(BuildContext context, ApiKey key) {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(localizations.confirm_delete_title),
        content: Text(localizations.confirm_delete_message(key.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(localizations.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await context.read<ApiKeyProvider>().deleteKey(key.id!);
            },
            child: Text(localizations.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final apiKeyProvider = Provider.of<ApiKeyProvider>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Tema
          SectionHeader(title: localizations.theme),
          SwitchListTile(
            title: Text(localizations.darkTheme),
            value: themeProvider.isDarkMode,
            onChanged: (_) => themeProvider.toggleTheme(),
          ),
          const Divider(height: 32),

          /// Idioma
          SectionHeader(title: localizations.language),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButtonFormField<Locale>(
              value: localeProvider.locale,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              onChanged: (newLocale) => localeProvider.setLocale(newLocale!),
              items: [
                DropdownMenuItem(
                  value: const Locale('es'),
                  child: Text(localizations.spanish),
                ),
                DropdownMenuItem(
                  value: const Locale('en'),
                  child: Text(localizations.english),
                ),
              ],
            ),
          ),
          const Divider(height: 32),

          /// API Keys
          SectionHeader(title: 'API Keys'),

          ...apiKeyProvider.keys.map(
            (apiKey) => Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                title: Text(apiKey.name),
                subtitle: Text(
                  apiKey.key,
                  style: const TextStyle(fontSize: 12),
                ),
                leading: Icon(
                  apiKey.isActive ? Icons.check_circle : Icons.circle_outlined,
                  color: apiKey.isActive ? Colors.green : Colors.grey,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!apiKey.isActive)
                      IconButton(
                        tooltip: localizations.active,
                        icon: const Icon(Icons.power_settings_new),
                        onPressed: () {
                          apiKeyProvider.activateKey(apiKey.id!);
                        },
                      ),
                    IconButton(
                      tooltip: localizations.edit,
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ApiKeyForm(existingKey: apiKey),
                        );
                      },
                    ),
                    IconButton(
                      tooltip: localizations.delete,
                      icon: const Icon(Icons.delete),
                      onPressed: () => _confirmDelete(context, apiKey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          if (apiKeyProvider.canAddMore)
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: Text(localizations.add_apikey),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const ApiKeyForm(),
                );
              },
            )
          else
            Text(
              localizations.exceeded_apikey_limit,
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
