class Radio {
  final String name;
  final String favicon;
  final String url;

  Radio({
    required this.name,
    required this.favicon,
    required this.url,
  });

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is Radio && runtimeType == other.runtimeType && url == other.url;

  @override
  int get hashCode => url.hashCode;

  Radio.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        favicon = json['favicon'],
        url = json['url'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'favicon': favicon,
        'url': url,
      };
}
