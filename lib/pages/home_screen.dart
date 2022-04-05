import 'package:final_submission/pages/favorite_screen.dart';
import 'package:final_submission/widgets/list_restaurant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _isNavbarActive = 0;

  final List<Widget> _listWidget = const [ListRestaurant(), FavoriteScreen()];

  final List<BottomNavigationBarItem> _bottomNavbarItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined), label: "Restaurant"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite_outline,
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
      ),
    );
  }
}
