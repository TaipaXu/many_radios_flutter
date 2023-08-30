import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  final String storageTheme = 'theme';

  Future<void> setTheme(ThemeMode theme) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(storageTheme, theme.toString().split('.').last);
  }

  Future<ThemeMode> getTheme() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? str = sp.getString(storageTheme);
    if (str == null) {
      return ThemeMode.system;
    } else {
      return ThemeMode.values
          .firstWhere((item) => item.toString() == 'ThemeMode.$str');
    }
  }
}

final themeStorage = ThemeStorage();
