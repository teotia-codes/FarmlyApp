import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class MarketDataRequest {
  final String apiKey;
  final String format;
  final int limit;
  final Map<String, String> filters;

  MarketDataRequest({
    required this.apiKey,
    required this.format,
    required this.limit,
    required this.filters,
  });

  // Method to convert the request model to query parameters
  Map<String, dynamic> toQueryParameters() {
    final queryParameters = {
      'api-key': apiKey,
      'format': format,
      'limit': limit.toString(),
    };

    // Add filters to the query parameters
    filters.forEach((key, value) {
      queryParameters['filters[$key]'] = value;
    });

    return queryParameters;
  }
}

// Function to fetch market data
Future<Map<String, dynamic>> fetchMarketData(MarketDataRequest request) async {
  final baseUrl = Uri.parse(
      'https://api.data.gov.in/resource/35985678-0d79-46b4-9ed6-6f13308a1d24');
  final uri = Uri(
    scheme: baseUrl.scheme,
    host: baseUrl.host,
    path: baseUrl.path,
    queryParameters: request.toQueryParameters(),
  );

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch market data: ${response.statusCode}');
  }
}
