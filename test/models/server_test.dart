import 'package:flutter_test/flutter_test.dart';
import 'package:many_radios/models/server.dart' as model;

void main() {
  group('Server', () {
    test('should return a Server object', () {
      final model.Server server = model.Server(
        name: 'name',
        ip: '127.0.0.1',
      );
      expect(server.name, 'name');
      expect(server.ip, '127.0.0.1');
    });

    test('should return true if two servers are equal', () {
      final model.Server server1 = model.Server(
        name: 'name',
        ip: '127.0.0.1',
      );
      final model.Server server2 = model.Server(
        name: 'name',
        ip: '127.0.0.1',
      );
      expect(server1 == server2, true);
    });

    test('should return false if two servers are not equal', () {
      final model.Server server1 = model.Server(
        name: 'name',
        ip: '127.0.0.1',
      );
      final model.Server server2 = model.Server(
        name: 'name',
        ip: '127.0.0.2',
      );
      expect(server1 == server2, false);
    });

    test('should return the same hashcode if two servers are equal', () {
      final model.Server server1 = model.Server(
        name: 'name',
        ip: '127.0.0.1',
      );
      final model.Server server2 = model.Server(
        name: 'name',
        ip: '127.0.0.1',
      );
      expect(server1.hashCode, server2.hashCode);
    });

    test('should return the same hashcode if two servers are not equal', () {
      final model.Server server1 = model.Server(
        name: 'name',
        ip: '127.0.0.1',
      );
      final model.Server server2 = model.Server(
        name: 'name',
        ip: '127.0.0.2',
      );
      expect(server1.hashCode, isNot(server2.hashCode));
    });

    test('should return a Server object from json', () {
      final Map<String, dynamic> json = {
        'name': 'name',
        'ip': '127.0.0.1',
      };
      final model.Server server = model.Server.fromJson(json);
      expect(server.name, 'name');
      expect(server.ip, '127.0.0.1');
    });

    test('should return a json from a Server object', () {
      final model.Server server = model.Server(
        name: 'name',
        ip: '127.0.0.1',
      );
      final Map<String, dynamic> json = server.toJson();
      expect(json['name'], 'name');
      expect(json['ip'], '127.0.0.1');
    });

    test('should return a string from a Server object', () {
      final model.Server server = model.Server(
        name: 'name',
        ip: '127.0.0.1',
      );
      expect(server.toString(), 'Server{name: name, ip: 127.0.0.1}');
    });

    test('should return a list of Server objects from a json list', () {
      final List<dynamic> jsonList = [
        {
          'name': 'name1',
          'ip': '127.0.0.1',
        },
        {
          'name': 'name2',
          'ip': '127.0.0.2',
        },
      ];
      final List<model.Server> servers = model.Server.fromJsonList(jsonList);
      expect(servers.length, 2);
      expect(servers[0].name, 'name1');
      expect(servers[0].ip, '127.0.0.1');
      expect(servers[1].name, 'name2');
      expect(servers[1].ip, '127.0.0.2');
    });

    test('should return a json list from a list of Server objects', () {
      final List<model.Server> servers = [
        model.Server(
          name: 'name1',
          ip: '127.0.0.1',
        ),
        model.Server(
          name: 'name2',
          ip: '127.0.0.2',
        ),
      ];
      final List<Map<String, dynamic>> jsonList =
          model.Server.toJsonList(servers);
      expect(jsonList.length, 2);
      expect(jsonList[0]['name'], 'name1');
      expect(jsonList[0]['ip'], '127.0.0.1');
      expect(jsonList[1]['name'], 'name2');
      expect(jsonList[1]['ip'], '127.0.0.2');
    });
  });
}
