import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/api_key_provider.dart';
import 'providers/locale_provider.dart';
import 'l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ApiKeyProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      locale: localeProvider.locale,
      supportedLocales: const [Locale('en'), Locale('es')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: Colors.blue, // Color base azul
              brightness: Brightness.light,
            ).copyWith(
              // Personalizar colores específicos si necesitas
              primary: Colors.blue[600]!,
              secondary: Colors.blue[400]!,
              surface: Colors.white,
            ),
        useMaterial3: true,
      ),

      // TEMA OSCURO (Azul + Negro)
      darkTheme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ).copyWith(
              primary: Colors.blue[400]!,
              secondary: Colors.blue[300]!,
              surface: Colors.grey[900]!,
            ),
        useMaterial3: true,
      ),

      themeMode: themeProvider.themeMode, // Sigue el sistema
      home: const HomeScreen(),
    );
  }
}
