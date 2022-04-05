import 'dart:io';

import 'package:flutter/foundation.dart';

import '../data/api/search_restaurant_service.dart';
import '../data/models/search_restaurant_model.dart';

enum ResultState { loading, noData, hasData, error }

class SearchRestaurantProvider extends ChangeNotifier {
  final SearchRestaurantService searchRestaurantService;

  SearchRestaurantProvider({required this.searchRestaurantService}) {
    fetchRestaurantSearch(query);
  }

  late SearchRestaurantResult _searchRestaurantResult;
  late ResultState _state;
  late String _message = '';
  final String _query = '';

  String get message => _message;

  SearchRestaurantResult get result => _searchRestaurantResult;

  ResultState get state => _state;

  String get query => _query;

  Future<dynamic> fetchRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants =
          await searchRestaurantService.getRestaurantSearch(query);
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchRestaurantResult = restaurants;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Internet Connection";
    } catch (err) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'error --> $err';
    }
  }
}
