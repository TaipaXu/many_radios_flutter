import 'package:flutter/material.dart';
import '/storages/theme.dart';

class Theme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  Theme() {
    themeStorage.getTheme().then((ThemeMode themeMode) {
      this.themeMode = themeMode;
    });
  }

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  final ThemeData lightThemeData = ThemeData(
    primarySwatch: Colors.orange,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  final ThemeData darkThemeData = ThemeData(
    primarySwatch: Colors.orange,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
  );
}

final theme = Theme();
