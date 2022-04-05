import 'package:final_submission/data/api/restaurants_service.dart';
import 'package:final_submission/data/api/search_restaurant_service.dart';
import 'package:final_submission/data/models/detail_model.dart';
import 'package:final_submission/pages/detail_screen.dart';
import 'package:final_submission/pages/home_screen.dart';
import 'package:final_submission/pages/search_screen.dart';
import 'package:final_submission/pages/splash_screen.dart';
import 'package:final_submission/providers/restaurants_provider.dart';
import 'package:final_submission/providers/search_provider.dart';
import 'package:final_submission/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
                  searchRestaurantService: SearchRestaurantService()))
        ],
        child: Consumer<RestaurantListProvider>(
          builder: ((context, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Final Submission 3",
              theme:
                  ThemeData(primaryColor: Colors.amber, textTheme: myTextTheme),
              initialRoute: SplashScreen.routeName,
              routes: {
                SplashScreen.routeName: (context) => const SplashScreen(),
                HomeScreen.routeName: (context) => const HomeScreen(),
                DetailScreen.routeName: (context) => DetailScreen(
                      id: ModalRoute.of(context)?.settings.arguments as String,
                    ),
                SearchScreen.routeName: (context) => const SearchScreen()
              },
            );
          }),
        ));
  }
}
