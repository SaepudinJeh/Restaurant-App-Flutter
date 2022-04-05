import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/detail_model.dart';
import '../themes/dimensions.dart';

class ListMenuFoods extends StatelessWidget {
  final DetailRestaurantResult foods;

  const ListMenuFoods({Key? key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(foods.toList());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Menu Makanan :",
            style: GoogleFonts.comfortaa(
                textStyle: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600))),
        SizedBox(height: Dimensions.height_20),
        ListView.builder(
            itemCount: foods.restaurant.menus.foods.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Text(
                  '- ${foods.restaurant.menus.foods[index].name.toString()}',
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
