import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/detail_model.dart';

class DetailRestorantService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<DetailRestaurantResult> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + 'detail/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load Restaurant');
    }

    return DetailRestaurantResult.fromJson(json.decode(response.body));
  }
}
