import '/network/request.dart';

Future<dynamic> getServers() async {
  return Request.get(
    'http://all.api.radio-browser.info/json/servers',
  );
}
