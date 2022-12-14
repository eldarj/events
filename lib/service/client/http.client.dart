import 'dart:async';

import 'package:http/http.dart' as http;

const String apiBaseUrl = 'http://192.168.1.139:8191';

class HttpClient {
  static Map<String, http.Response> cache = {};

  static Future<http.Response?> get(url, {cacheKey}) async {
    if (cacheKey != null && cache.containsKey(cacheKey)) {
      return cache[cacheKey];
    }

    var response = await http
        .get(
          Uri.parse(apiBaseUrl + url),
          // headers: {'content-type': 'application/json', 'authorization': 'Bearer $userToken'}
        )
        .timeout(const Duration(seconds: 10));

    if (cacheKey != null) {
      cache[cacheKey] = response;
    }

    return response;
  }
}
