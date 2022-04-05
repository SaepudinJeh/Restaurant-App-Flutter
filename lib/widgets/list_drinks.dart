import 'package:final_submission/data/models/detail_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/dimensions.dart';

class ListMenuDrinks extends StatelessWidget {
  final DetailRestaurantResult drinks;
  const ListMenuDrinks({Key? key, required this.drinks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(drinks.toList());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Menu Minuman :",
            style: GoogleFonts.comfortaa(
                textStyle: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600))),
        SizedBox(height: Dimensions.height_20),
        ListView.builder(
            itemCount: drinks.restaurant.menus.drinks.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Text(
                  '- ${drinks.restaurant.menus.drinks[index].name.toString()}',
                  style: GoogleFonts.comfortaa(
                      textStyle: const TextStyle(
                          fontSize: 15.0,
                          height: 2.0,
                          fontWeight: FontWeight.w600)));
            })
      ],
    );
  }
}
