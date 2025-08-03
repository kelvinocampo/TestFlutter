import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    context.read<ApiKeyProvider>().loadKeys();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _confirmDelete(BuildContext context, ApiKey key) {
    final localizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    HapticFeedback.mediumImpact();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_rounded, color: colorScheme.error, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                localizations.confirm_delete_title,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          localizations.confirm_delete_message(key.name),
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(localizations.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await context.read<ApiKeyProvider>().deleteKey(key.id!);
              if (mounted) {
                HapticFeedback.lightImpact();
              }
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: colorScheme.onSurface,
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        title: Text(
          localizations.settings,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Sección Tema
            _buildSection(
              context: context,
              title: localizations.theme,
              icon: Icons.palette_rounded,
              children: [
                _buildThemeToggle(themeProvider, localizations, colorScheme),
              ],
            ),

            const SizedBox(height: 24),

            // Sección Idioma
            _buildSection(
              context: context,
              title: localizations.language,
              icon: Icons.language_rounded,
              children: [
                _buildLanguageSelector(
                  localeProvider,
                  localizations,
                  colorScheme,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Sección API Keys
            _buildSection(
              context: context,
              title: 'API Keys',
              icon: Icons.key_rounded,
              children: [
                ...apiKeyProvider.keys.map(
                  (apiKey) => _buildApiKeyCard(
                    apiKey,
                    apiKeyProvider,
                    localizations,
                    colorScheme,
                  ),
                ),
                const SizedBox(height: 16),
                _buildAddApiKeyButton(
                  apiKeyProvider,
                  localizations,
                  colorScheme,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Información adicional
            _buildInfoCard(localizations, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary.withValues(alpha: 0.1),
                  colorScheme.secondary.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: colorScheme.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeToggle(
    ThemeProvider themeProvider,
    AppLocalizations localizations,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(
          localizations.darkTheme,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          themeProvider.isDarkMode
              ? localizations.active_darktheme
              : localizations.active_lighttheme,
          style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
        ),
        value: themeProvider.isDarkMode,
        onChanged: (_) {
          HapticFeedback.lightImpact();
          themeProvider.toggleTheme();
        },
        activeColor: colorScheme.primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildLanguageSelector(
    LocaleProvider localeProvider,
    AppLocalizations localizations,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonFormField<Locale>(
        value: localeProvider.locale,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: colorScheme.surfaceContainerHighest,
        onChanged: (newLocale) {
          HapticFeedback.lightImpact();
          localeProvider.setLocale(newLocale!);
        },
        items: [
          DropdownMenuItem(
            value: const Locale('es'),
            child: Row(
              children: [
                Text('🇪🇸'),
                const SizedBox(width: 12),
                Text(localizations.spanish),
              ],
            ),
          ),
          DropdownMenuItem(
            value: const Locale('en'),
            child: Row(
              children: [
                Text('🇺🇸'),
                const SizedBox(width: 12),
                Text(localizations.english),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApiKeyCard(
    ApiKey apiKey,
    ApiKeyProvider apiKeyProvider,
    AppLocalizations localizations,
    ColorScheme colorScheme,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: apiKey.isActive
              ? colorScheme.primary.withValues(alpha: 0.3)
              : colorScheme.outline.withValues(alpha: 0.2),
          width: apiKey.isActive ? 2 : 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Row(
          children: [
            Expanded(
              child: Text(
                apiKey.name,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (apiKey.isActive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  localizations.key_active,
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${apiKey.key.substring(0, 12)}...',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!apiKey.isActive)
              IconButton(
                tooltip: localizations.active,
                icon: Icon(
                  Icons.power_settings_new_rounded,
                  color: colorScheme.primary,
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  apiKeyProvider.activateKey(apiKey.id!);
                },
              ),
            IconButton(
              tooltip: localizations.edit,
              icon: Icon(
                Icons.edit_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                showDialog(
                  context: context,
                  builder: (_) => ApiKeyForm(existingKey: apiKey),
                );
              },
            ),
            IconButton(
              tooltip: localizations.delete,
              icon: Icon(Icons.delete_rounded, color: colorScheme.error),
              onPressed: () => _confirmDelete(context, apiKey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddApiKeyButton(
    ApiKeyProvider apiKeyProvider,
    AppLocalizations localizations,
    ColorScheme colorScheme,
  ) {
    if (apiKeyProvider.canAddMore) {
      return SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          icon: const Icon(Icons.add_rounded),
          label: Text(localizations.add_apikey),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            showDialog(context: context, builder: (_) => const ApiKeyForm());
          },
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.warning_rounded,
              color: colorScheme.onErrorContainer,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                localizations.exceeded_apikey_limit,
                style: TextStyle(
                  color: colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildInfoCard(
    AppLocalizations localizations,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.3),
            colorScheme.secondaryContainer.withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_rounded, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                localizations.info,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            localizations.app_info,
            style: TextStyle(color: colorScheme.onSurfaceVariant, height: 1.4),
          ),
        ],
      ),
    );
  }
}
