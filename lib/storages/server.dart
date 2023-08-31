import 'dart:convert';
import '/models/server.dart' as model;
import './serializer.dart';

class ServerSerializer extends Serializer<model.Server, model.Server?> {
  @override
  String encode(model.Server data) {
    return json.encode(data.toJson());
  }

  @override
  model.Server? decode(String? data) {
    if (data == null) {
      return null;
    } else {
      return model.Server.fromJson(json.decode(data));
    }
  }
}

class ServerStorage extends Storage<model.Server, model.Server?> {
  ServerStorage() : super('server', ServerSerializer());

  Future<String> getServerIp() async {
    final model.Server? server = await this.get();
    return server?.ip ?? '89.58.16.19';
  }
}

final serverStorage = ServerStorage();
