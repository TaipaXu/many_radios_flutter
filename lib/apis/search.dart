import '/network/request.dart';

Future<dynamic> getCountries() async {
  return Request.get(
    'http://95.179.139.106/json/countries',
  );
}

Future<dynamic> getLanguages() async {
  return Request.get(
    'http://95.179.139.106/json/languages',
  );
}

Future<dynamic> searchRadios(
    {String? name,
    String? country,
    String? language,
    int offset = 0,
    int limit = 10}) async {
  return Request.get(
    'http://95.179.139.106/json/stations/search',
    params: {
      'name': name ?? '',
      'country': country ?? '',
      'language': language ?? '',
      'offset': offset,
      'limit': limit,
    },
  );
}
