import 'package:flutter/material.dart';

import '../data/models/restaurant_list_model.dart';
import '../helpers/db_helper.dart';

enum ResultState { loading, noData, hasData, error }

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  List<Restaurant> _favorites = [];
  late ResultState _state;
  String _message = '';

  String get message => _message;

  List<Restaurant> get favorites => _favorites;

  ResultState get state => _state;

  void _getFavorite() async {
    _state = ResultState.loading;
    notifyListeners();

    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Tidak ada yang diFavoritkan :)';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorite();
    } catch (err) {
      _state = ResultState.error;
      _message = 'Error: $err';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (err) {
      _state = ResultState.error;
      _message = 'Error: $err';
      notifyListeners();
    }
  }
}
