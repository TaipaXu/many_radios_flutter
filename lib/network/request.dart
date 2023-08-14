import 'package:http/http.dart' as http;
import 'dart:convert';

class Request {
  static Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    final Uri uri = Uri.parse(url);
    final stringParams = <String, dynamic>{};
    if (params != null) {
      params.forEach((key, value) {
        stringParams[key] = value.toString();
      });
    }
    final http.Response response =
        await http.get(uri.replace(queryParameters: stringParams));
    if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }
    return jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
  }
}
