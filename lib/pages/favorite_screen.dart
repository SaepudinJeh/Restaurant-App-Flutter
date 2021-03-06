import 'package:final_submission/themes/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/db_provider.dart';
import '../widgets/item_restaurant.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(top: Dimensions.height_20),
                  child: ItemRestaurant(restaurant: state.favorites[index]));
            },
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                  child: Text(state.message,
                      style: GoogleFonts.comfortaa(
                          textStyle: const TextStyle(fontSize: 20.0)))),
            ),
          );
        }
      },
    );
  }
}
