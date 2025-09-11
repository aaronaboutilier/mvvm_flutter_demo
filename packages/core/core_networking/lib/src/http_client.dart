import 'dart:convert';

import 'package:http/http.dart' as http;

import 'network_result.dart';

class CoreHttpClient {
  CoreHttpClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<NetworkResult<Map<String, dynamic>>> getJson(Uri url, {Map<String, String>? headers}) async {
    try {
      final res = await _client.get(url, headers: headers);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return NetworkOk(json.decode(res.body) as Map<String, dynamic>);
      }
      return NetworkErr('HTTP ${res.statusCode}', res.statusCode);
    } catch (e) {
      return NetworkErr(e);
    }
  }

  void close() => _client.close();
}
