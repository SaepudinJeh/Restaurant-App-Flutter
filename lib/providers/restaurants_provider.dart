import 'dart:io';

import 'package:flutter/material.dart';

import '../data/api/restaurants_service.dart';
import '../data/models/restaurant_list_model.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantListProvider extends ChangeNotifier {
  final RestaurantService restaurantService;

  RestaurantListProvider({required this.restaurantService}) {
    _fetchAllRestaurant();
  }

  late RestaurantResult _restaurantResult;

  late ResultState _state;

  late String _message = '';

  // Getter And Setter
  String get message => _message;
  RestaurantResult get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await restaurantService.getRestaurantList();

      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Internet Connection";
    } catch (err) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'error : $err';
    }
  }
}
