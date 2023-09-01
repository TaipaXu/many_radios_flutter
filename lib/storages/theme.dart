import 'package:flutter/material.dart';
import './serializer.dart';

class ThemeSerializer extends Serializer<ThemeMode, ThemeMode> {
  @override
  String encode(ThemeMode data) {
    return data.toString().split('.').last;
  }

  @override
  ThemeMode decode(String? data) {
    if (data == null) {
      return ThemeMode.system;
    } else {
      return ThemeMode.values
          .firstWhere((item) => item.toString() == 'ThemeMode.$data');
    }
  }
}

class ThemeStorage extends Storage<ThemeMode, ThemeMode> {
  ThemeStorage() : super('theme', ThemeSerializer());
}

final themeStorage = ThemeStorage();
