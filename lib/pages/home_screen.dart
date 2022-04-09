import 'package:final_submission/helpers/notification_helper.dart';
import 'package:final_submission/pages/favorite_screen.dart';
import 'package:final_submission/widgets/list_restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _isNavbarActive = 0;

  final List<Widget> _listWidget = const [ListRestaurant(), FavoriteScreen()];

  final List<BottomNavigationBarItem> _bottomNavbarItems = const [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.house_alt), label: "Restaurant"),
    BottomNavigationBarItem(
        icon: Icon(
          CupertinoIcons.heart_circle,
        ),
        label: "Favorite"),
  ];

  void _navbarActiveIndex(int index) {
    setState(() {
      _isNavbarActive = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_isNavbarActive],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _isNavbarActive,
        items: _bottomNavbarItems,
        onTap: _navbarActiveIndex,
        selectedItemColor: Colors.deepOrange,
      ),
    );
  }
}
