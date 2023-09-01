import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:many_radios/storages/server.dart';
import 'package:many_radios/models/server.dart' as model;

void main() {
  group('Server', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('should set a server', () async {
      final model.Server server = model.Server(
        name: 'name',
        ip: '192.168.1.1',
      );
      await serverStorage.set(server);

      final model.Server? storedRadio = await serverStorage.get();
      expect(storedRadio != null, true);
      expect(storedRadio!.name, 'name');
      expect(storedRadio.ip, '192.168.1.1');
    });

    test('should get null if there are no server', () async {
      final model.Server? storedRadio = await serverStorage.get();
      expect(storedRadio, null);
    });

    test('should get a defulat server ip', () async {
      final String ip = await serverStorage.getServerIp();
      expect(ip, '89.58.16.19');
    });

    test('should get a setted server ip', () async {
      final model.Server server = model.Server(
        name: 'name',
        ip: '192.168.1.1',
      );
      await serverStorage.set(server);

      final String ip = await serverStorage.getServerIp();
      expect(ip, '192.168.1.1');
    });
  });
}
