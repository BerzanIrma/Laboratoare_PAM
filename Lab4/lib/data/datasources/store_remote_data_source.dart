
import 'dart:convert';
import 'package:http/http.dart' as http;

class StoreRemoteDataSource {
  final http.Client client;

  StoreRemoteDataSource({required this.client});

  static const String baseUrl =
      'https://test-api-jlbn.onrender.com/lab2026/v1';

  Future<Map<String, dynamic>>? _feedCache;
  Future<Map<String, dynamic>>? _detailsCache;

  // Preluarea datelor pentru Home Page
  Future<Map<String, dynamic>> getFeed() {
    return _feedCache ??= _fetchFeed();
  }

  Future<Map<String, dynamic>> _fetchFeed() async {
    final response = await client.get(
      Uri.parse('$baseUrl/feed'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
      as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to load feed: ${response.statusCode}',
      );
    }
  }

  // Preluarea datelor pentru Product Page
  Future<Map<String, dynamic>> getProductDetails() {
    return _detailsCache ??= _fetchProductDetails();
  }

  Future<Map<String, dynamic>> _fetchProductDetails() async {
    final response = await client.get(
      Uri.parse('$baseUrl/feed/details'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
      as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to load product details: ${response.statusCode}',
      );
    }
  }
}
