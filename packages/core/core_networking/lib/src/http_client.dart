import 'dart:convert';

import 'package:core_networking/src/network_result.dart';
import 'package:http/http.dart' as http;

/// Core HTTP client for network requests.
class CoreHttpClient {
  /// Creates a [CoreHttpClient] with an optional [http.Client].
  CoreHttpClient({http.Client? client}) : _client = client ?? http.Client();

  /// The underlying HTTP client.
  final http.Client _client;

  /// Performs a GET request and returns a JSON-decoded result.
  Future<NetworkResult<Map<String, dynamic>>> getJson(
    Uri url, {
    Map<String, String>? headers,
  }) async {
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

  /// Closes the HTTP client.
  void close() => _client.close();
}
