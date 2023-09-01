import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class Serializer<T, U> {
  String encode(T data);

  U decode(String? data);
}

abstract class Storage<T, U> {
  final String _key;
  final Serializer<T, U> _serializer;

  Storage(this._key, this._serializer);

  Future<U> get() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? str = sp.getString(_key);
    return _serializer.decode(str);
  }

  Future<void> set(T data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(_key, _serializer.encode(data));
  }

  Future<void> clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove(_key);
  }
}

// abstract class ListSerializable<T> extends Serializer<T, T> {
//   List<T>? fromJson(List<dynamic> json);

//   List<Map<String, dynamic>> toJson();
// }

abstract class ListStorage<T> {
  final String _key;
  final Serializer<T, T> _serializer;

  ListStorage(this._key, this._serializer);

  Future<List<T>?> get() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? str = sp.getString(_key);
    if (str == null) {
      return null;
    } else {
      Iterable items = json.decode(str);
      return items.map((item) => _serializer.decode(item)).toList();
    }
  }

  Future<void> set(List<T> data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(_key,
        json.encode(data.map((item) => _serializer.encode(item)).toList()));
  }

  Future<void> add(T item) async {
    List<T>? data = await get();
    if (data != null) {
      if (!data.contains(item)) {
        data.add(item);
        await set(data);
      }
    } else {
      await set([item]);
    }
  }

  Future<bool> contains(T item) async {
    List<T>? data = await get();
    if (data != null) {
      return data.contains(item);
    } else {
      return false;
    }
  }

  Future<void> remove(T item) async {
    List<T>? data = await get();
    if (data != null) {
      data.remove(item);
      await set(data);
    }
  }
}
