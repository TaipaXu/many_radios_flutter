class Server {
  final String name;
  final String ip;

  Server({
    required this.name,
    required this.ip,
  });

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is Server && runtimeType == other.runtimeType && ip == other.ip;

  @override
  int get hashCode => ip.hashCode;

  Server.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        ip = json['ip'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'ip': ip,
      };

  @override
  String toString() {
    return 'Server{name: $name, ip: $ip}';
  }

  static List<Server> fromJsonList(List<dynamic> jsonList) {
    List<Server> servers = [];
    for (var json in jsonList) {
      servers.add(Server.fromJson(json));
    }
    return servers;
  }

  static List<Map<String, dynamic>> toJsonList(List<Server> servers) {
    List<Map<String, dynamic>> jsonList = [];
    for (var server in servers) {
      jsonList.add(server.toJson());
    }
    return jsonList;
  }
}
