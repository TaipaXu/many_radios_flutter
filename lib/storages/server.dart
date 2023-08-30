import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/server.dart' as model;

class ServerStorage {
  final String storageServer = 'server';

  Future<void> setServer(model.Server server) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(storageServer, json.encode(server.toJson()));
  }

  Future<model.Server?> getServer() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? str = sp.getString(storageServer);
    if (str == null) {
      return null;
    } else {
      return model.Server.fromJson(json.decode(str));
    }
  }

  Future<String> getServerIp() async {
    final model.Server? server = await getServer();
    return server?.ip ?? '89.58.16.19';
  }
}

final serverStorage = ServerStorage();
