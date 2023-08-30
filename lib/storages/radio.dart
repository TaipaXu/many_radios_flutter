import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/radio.dart' as model;

class RadioStorage {
  final String storageFavorite = 'favorites';

  Future<void> addFavoriteRadio(model.Radio radio) async {
    if (await isFavoriteRadio(radio)) {
      return;
    }
    List<model.Radio>? statoins = await getFavoriteRadios();
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (statoins != null) {
      statoins.add(radio);
      await sp.setString(storageFavorite, json.encode(statoins));
    } else {
      await sp.setString(storageFavorite, json.encode([radio]));
    }
  }

  Future<void> removeFavoriteRadio(model.Radio radio) async {
    List<model.Radio>? statoins = await getFavoriteRadios();
    if (statoins != null) {
      statoins.remove(radio);
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString(storageFavorite, json.encode(statoins));
    }
  }

  Future<bool> isFavoriteRadio(model.Radio radio) async {
    List<model.Radio> statoins = await getFavoriteRadios() ?? [];
    return statoins.contains(radio);
  }

  Future<List<model.Radio>?> getFavoriteRadios() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? str = sp.getString(storageFavorite);
    if (str == null) {
      return null;
    } else {
      Iterable items = json.decode(str);
      return items.map((item) => model.Radio.fromJson(item)).toList();
    }
  }
}

final RadioStorage radioStorage = RadioStorage();
