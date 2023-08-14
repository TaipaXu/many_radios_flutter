import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import '/pages/splash.dart' as page;
import '/pages/home.dart' as page;
import '/pages/settings.dart' as page;
import '/stores/radio.dart' as store;
import '/stores/theme.dart' as store;

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => store.radio),
      ChangeNotifierProvider(create: (_) => store.theme),
    ],
    child: const MyApp(),
  ));

  SystemUiOverlayStyle systemUiOverlayStyle =
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final store.Theme themeStore = Provider.of<store.Theme>(context);

    return MaterialApp(
      title: 'Many Radios',
      themeMode: themeStore.themeMode,
      theme: themeStore.lightThemeData,
      darkTheme: themeStore.darkThemeData,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const page.Splash(),
        'home': (context) => const page.Home(),
        'settings': (context) => const page.Settings(),
      },
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}