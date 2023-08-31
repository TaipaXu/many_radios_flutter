import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:many_radios/storages/theme.dart';

void main() {
  group('Theme', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('should set a theme', () async {
      await themeStorage.set(ThemeMode.dark);

      final ThemeMode theme = await themeStorage.get();
      expect(theme, ThemeMode.dark);
    });

    test('should get a default theme', () async {
      final ThemeMode theme = await themeStorage.get();
      expect(theme, ThemeMode.system);
    });
  });
}
