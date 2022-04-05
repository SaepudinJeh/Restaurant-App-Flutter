import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/restaurant_list_model.dart';

class RestaurantService {
  static const String _baseURL = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> getRestaurantList() async {
    final response = await http.get(Uri.parse(_baseURL + "list"));
    if (response.statusCode != 200) {
      throw Exception('Failed to load Restaurant!');
    }

    return RestaurantResult.fromJson(json.decode(response.body));
  }
}
