import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../data/api/detail_restaurant_service.dart';
import '../data/models/detail_model.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final DetailRestorantService detailRestorantService;
  final String? id;

  DetailRestaurantProvider(
      {required this.detailRestorantService, required this.id}) {
    _fetchDetailRestorant();
  }

  late DetailRestaurantResult _detailRestaurantServie;
  late ResultState _state;
  late String _message = '';

  // Get and Setter
  String get message => _message;
  DetailRestaurantResult get result => _detailRestaurantServie;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestorant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant =
          await detailRestorantService.getDetailRestaurant(id!);

      if (detailRestaurant.message.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurantServie = detailRestaurant;
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
