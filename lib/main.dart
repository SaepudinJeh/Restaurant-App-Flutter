import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:final_submission/common/navigation.dart';
import 'package:final_submission/data/api/restaurants_service.dart';
import 'package:final_submission/data/api/search_restaurant_service.dart';
import 'package:final_submission/data/models/restaurant_list_model.dart';
import 'package:final_submission/helpers/db_helper.dart';
import 'package:final_submission/helpers/notification_helper.dart';
import 'package:final_submission/pages/detail_screen.dart';
import 'package:final_submission/pages/home_screen.dart';
import 'package:final_submission/pages/notification_screen.dart';
import 'package:final_submission/pages/search_screen.dart';
import 'package:final_submission/pages/splash_screen.dart';
import 'package:final_submission/providers/db_provider.dart';
import 'package:final_submission/providers/preferences_provider.dart';
import 'package:final_submission/providers/restaurants_provider.dart';
import 'package:final_submission/providers/scheduling_provider.dart';
import 'package:final_submission/providers/search_provider.dart';
import 'package:final_submission/themes/text_theme.dart';
import 'package:final_submission/utils/background_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => RestaurantListProvider(
                  restaurantService: RestaurantService())),
          ChangeNotifierProvider(
              create: (_) => SearchRestaurantProvider(
                  searchRestaurantService: SearchRestaurantService())),
          ChangeNotifierProvider(create: (_) => SchedulingProvider()),
          ChangeNotifierProvider(
              create: (_) =>
                  DatabaseProvider(databaseHelper: DatabaseHelper())),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
        ],
        child: Consumer<RestaurantListProvider>(
          builder: ((context, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              title: "Final Submission 3",
              theme:
                  ThemeData(primaryColor: Colors.amber, textTheme: myTextTheme),
              initialRoute: SplashScreen.routeName,
              routes: {
                SplashScreen.routeName: (context) => const SplashScreen(),
                HomeScreen.routeName: (context) => const HomeScreen(),
                DetailScreen.routeName: (context) => DetailScreen(
                      restaurant: ModalRoute.of(context)?.settings.arguments
                          as Restaurant,
                    ),
                SearchScreen.routeName: (context) => const SearchScreen(),
                NotificationScreen.routeName: (context) =>
                    const NotificationScreen()
              },
            );
          }),
        ));
  }
}
