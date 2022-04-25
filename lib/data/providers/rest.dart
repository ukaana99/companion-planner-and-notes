import 'dart:convert';
import 'package:http/http.dart' as http;

class Rest {
  static const String baseUrl = '';

  const Rest._();

  static Future get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  static Future post(String endpoint, {dynamic data}) async {
    final response = await http.post(Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  static Future patch(String endpoint, {dynamic data}) async {
    final response = await http.patch(Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  static Future delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }
}
