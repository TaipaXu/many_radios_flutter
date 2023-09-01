import 'dart:convert';
import '/models/radio.dart' as model;
import './serializer.dart';

class RadioSerializer extends Serializer<model.Radio, model.Radio> {
  @override
  model.Radio decode(String? data) {
    return model.Radio.fromJson(json.decode(data!));
  }

  @override
  String encode(model.Radio data) {
    return json.encode(data.toJson());
  }
}

class RadioStorage extends ListStorage<model.Radio> {
  RadioStorage() : super('favorites', RadioSerializer());
}

final RadioStorage radioStorage = RadioStorage();
