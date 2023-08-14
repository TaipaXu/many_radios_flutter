import '/network/request.dart';
import '/models/topRadios.dart' as model;

Future<dynamic> getRadiosByType(
    {required model.TopRadiosType type, int offset = 0, int limit = 10}) async {
  late String url;
  switch (type) {
    case model.TopRadiosType.byClicks:
      url = 'http://89.58.16.19/json/stations/topclick';
      break;
    case model.TopRadiosType.byVotes:
      url = 'http://89.58.16.19/json/stations/topvote';
      break;
    case model.TopRadiosType.byRecentClick:
      url = 'http://89.58.16.19/json/stations/lastclick';
      break;
    case model.TopRadiosType.byRecentlyChange:
      url = 'http://89.58.16.19/json/stations/lastchange';
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
