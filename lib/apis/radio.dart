import '/network/request.dart';
import '/models/topRadios.dart' as model;
import '/storages/server.dart';

Future<dynamic> getRadiosByType(
    {required model.TopRadiosType type, int offset = 0, int limit = 10}) async {
  final String ip = await serverStorage.getServerIp();
  late String url;
  switch (type) {
    case model.TopRadiosType.byClicks:
      url = 'http://$ip/json/stations/topclick';
      break;
    case model.TopRadiosType.byVotes:
      url = 'http://$ip/json/stations/topvote';
      break;
    case model.TopRadiosType.byRecentClick:
      url = 'http://$ip/json/stations/lastclick';
      break;
    case model.TopRadiosType.byRecentlyChange:
      url = 'http://$ip/json/stations/lastchange';
      break;
  }

  return Request.get(
    url,
    params: {
      'offset': offset,
      'limit': limit,
    },
  );
}
