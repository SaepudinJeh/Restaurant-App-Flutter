import 'package:final_submission/common/navigation.dart';
import 'package:final_submission/providers/search_provider.dart';
import 'package:final_submission/widgets/search_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../themes/dimensions.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-restaurant';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: const EdgeInsets.all(16.0),
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: Dimensions.icon_30,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    Navigation.back();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Pencarian Restaurant dan Menu',
                    style: GoogleFonts.comfortaa(
                        textStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.height_20, right: Dimensions.height_20),
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                      width: double.infinity,
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            )
                          ],
                          border: Border.all(width: 0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0))),
                      child: TextFormField(
                        controller: _controller,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              query = value;
                            });
                            state.fetchRestaurantSearch(query);
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Pencarian Restaurant",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              color: Colors.orange,
                              onPressed: () {},
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.only(left: 15, top: 15)),
                      )),
                ),
                (query.isEmpty)
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 70.0, left: 30.0, right: 30.0),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                  'Tekan Search dan temukan Restaurant favoritmu!',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.comfortaa(
                                      textStyle: TextStyle(
                                          color:
                                              Colors.black87.withOpacity(0.5),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                      )
                    : const SearchRestaurantList()
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.clear();
  }
}
