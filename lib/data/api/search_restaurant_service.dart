import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/search_restaurant_model.dart';

class SearchRestaurantService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<SearchRestaurantResult> getRestaurantSearch(String query) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + 'search?q=$query'));
      if (response.statusCode == 200) {
        return SearchRestaurantResult.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load restaurant search');
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
