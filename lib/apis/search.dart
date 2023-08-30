import '/network/request.dart';
import '/storages/server.dart';

Future<dynamic> getCountries() async {
  final String ip = await serverStorage.getServerIp();
  return Request.get(
    'http://$ip/json/countries',
  );
}

Future<dynamic> getLanguages() async {
  final String ip = await serverStorage.getServerIp();
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
  final String ip = await serverStorage.getServerIp();
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
