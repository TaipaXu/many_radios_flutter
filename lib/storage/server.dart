import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/server.dart' as model;

class ServerStorage {
  static const String storageServer = 'server';

  static Future<void> setServer(model.Server server) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(storageServer, json.encode(server.toJson()));
  }

  static Future<model.Server?> getServer() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? str = sp.getString(storageServer);
    if (str == null) {
      return null;
    } else {
      return model.Server.fromJson(json.decode(str));
    }
  }
}
