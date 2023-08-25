import '/network/request.dart';
import '/storage/server.dart' as storage;

Future<dynamic> getCountries() async {
  final String ip = await storage.ServerStorage.getServerIp();
  return Request.get(
    'http://$ip/json/countries',
  );
}

Future<dynamic> getLanguages() async {
  final String ip = await storage.ServerStorage.getServerIp();
  return Request.get(
    'http://$ip/json/languages',
  );
}

Future<dynamic> searchRadios(
    {String? name,
    String? country,
    String? language,
    int offset = 0,
    int limit = 10}) async {
  final String ip = await storage.ServerStorage.getServerIp();
  return Request.get(
    'http://$ip/json/stations/search',
    params: {
      'name': name ?? '',
      'country': country ?? '',
      'language': language ?? '',
      'offset': offset,
      'limit': limit,
    },
  );
}
