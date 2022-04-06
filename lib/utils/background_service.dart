import 'dart:isolate';
import 'dart:math';

import 'dart:ui';

import 'package:final_submission/data/api/restaurants_service.dart';
import 'package:flutter/foundation.dart';

import '../helpers/notification_helper.dart';
import '../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm fired!');
    }
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await RestaurantService().getRestaurantList();

    final _random = Random();
    var restaurant =
        result.restaurants[_random.nextInt(result.restaurants.length)];

    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
