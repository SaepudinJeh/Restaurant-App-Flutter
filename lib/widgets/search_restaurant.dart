import 'package:final_submission/widgets/item_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/search_provider.dart';

class SearchRestaurantList extends StatelessWidget {
  const SearchRestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Padding(
            padding: EdgeInsets.only(top: 150.0),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
                semanticsLabel: 'Loading...',
                color: Colors.orange,
              ),
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return SafeArea(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                return ItemSearch(restaurant: state.result.restaurants[index]);
              },
            ),
          );
        } else if (state.state == ResultState.noData) {
          return Center(
              child: Text("Restaurant tidak ditemukan",
                  style: GoogleFonts.comfortaa(
                      textStyle: const TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold))));
        } else if (state.state == ResultState.error) {
          return Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
            child: Center(
              child: Text(
                'Hmmmm ... Sepertinya koneksi internet kamu bermasalah :(',
                textAlign: TextAlign.center,
                style: GoogleFonts.comfortaa(
                    textStyle: const TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          );
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
