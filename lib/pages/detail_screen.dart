import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/api/detail_restaurant_service.dart';
import '../providers/detail_restaurant_provider.dart';
import '../themes/dimensions.dart';
import '../widgets/list_drinks.dart';
import '../widgets/list_foods.dart';
import '../widgets/star_rating.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/restaurant-detail';

  final String id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ChangeNotifierProvider<DetailRestaurantProvider>(
          create: (_) => DetailRestaurantProvider(
              detailRestorantService: DetailRestorantService(), id: widget.id),
          child:
              Consumer<DetailRestaurantProvider>(builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 6.0,
                semanticsLabel: 'Loading ...',
              ));
            } else if (state.state == ResultState.hasData) {
              return _ListDetail(data: state);
            } else if (state.state == ResultState.noData) {
              return Center(
                  child: Padding(
                padding:
                    const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
                child: Center(
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ));
            } else if (state.state == ResultState.error) {
              return Center(
                  child: Padding(
                padding:
                    const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
                child: Center(
                  child: Text(
                    'Hmmmm ... Sepertinya koneksi internet kamu bermasalah :(',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                        textStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ));
            } else {
              return const Center(child: Text(''));
            }
          }),
        ));
  }
}

class _ListDetail extends StatelessWidget {
  final DetailRestaurantProvider data;
  const _ListDetail({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 5.0)
                        ]),
                    child: Hero(
                      tag: data.result.restaurant.pictureId,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                          child: Image.network(
                              "https://restaurant-api.dicoding.dev/images/medium/${data.result.restaurant.pictureId}",
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                          iconSize: Dimensions.icon_35,
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/search_screen'),
                          icon: const Icon(Icons.search_rounded),
                          iconSize: Dimensions.icon_35,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      left: 20.0,
                      bottom: 20.0,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: Dimensions.icon_30,
                            color: Colors.white60,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            data.result.restaurant.city,
                            style: GoogleFonts.comfortaa(
                                textStyle: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                padding: EdgeInsets.all(Dimensions.height_30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.result.restaurant.name,
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: Dimensions.height_20),
                    Row(
                      children: [
                        StarRating(star: data.result.restaurant.rating),
                        SizedBox(width: Dimensions.height_20),
                        Text(data.result.restaurant.rating.toString(),
                            style: GoogleFonts.comfortaa(
                                textStyle: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(width: Dimensions.height_10),
                        Text("Rating",
                            style: GoogleFonts.comfortaa(
                                textStyle:
                                    TextStyle(fontSize: Dimensions.font_20)))
                      ],
                    ),
                    SizedBox(height: Dimensions.height_20),
                    Text(
                      data.result.restaurant.description,
                      style: GoogleFonts.comfortaa(
                          textStyle: const TextStyle(fontSize: 18.0)),
                    ),
                    SizedBox(height: Dimensions.height_30),
                    ListMenuFoods(foods: data.result),
                    SizedBox(height: Dimensions.height_30),
                    ListMenuDrinks(drinks: data.result)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
