import 'package:final_submission/pages/search_screen.dart';
import 'package:final_submission/widgets/item_restaurant.dart';
import 'package:final_submission/widgets/menu_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api/restaurants_service.dart';
import '../providers/restaurants_provider.dart';
import '../themes/dimensions.dart';

class ListRestaurant extends StatelessWidget {
  const ListRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RestaurantListProvider(restaurantService: RestaurantService()),
      child: Scaffold(
          body: SafeArea(
              child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height_40),
                  padding: EdgeInsets.only(
                      left: Dimensions.height_30, right: Dimensions.height_30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Makan Nyok!",
                              style: Theme.of(context).textTheme.headline4),
                          Text(
                            "Anda senang kami sudah dari dulu",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.pushNamed(
                            context, SearchScreen.routeName),
                        icon: const Icon(Icons.search_rounded),
                        iconSize: Dimensions.icon_35,
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                ),
                // SizedBox(height: Dimensions.height_40),
              ],
            ),
          ])),
          SliverList(delegate: SliverChildListDelegate([const MenuCarousel()])),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.only(
                  left: Dimensions.height_30,
                  right: Dimensions.height_30,
                  top: Dimensions.height_30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rekomendasi Restaurant",
                      style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: Dimensions.height_10),
                  Text('Hanya untukmu',
                      style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(height: Dimensions.height_10),
                ],
              ),
            ),
            SizedBox(height: Dimensions.font_10),
          ])),
          Consumer<RestaurantListProvider>(builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return SliverList(
                  delegate: SliverChildListDelegate(
                      [const Center(child: CircularProgressIndicator())]));
            } else if (state.state == ResultState.hasData) {
              return SliverList(
                  delegate: SliverChildBuilderDelegate(((context, index) {
                return Column(
                  children: [
                    SizedBox(height: Dimensions.height_15),
                    ItemRestaurant(restaurant: state.result.restaurants[index])
                  ],
                );
              }), childCount: state.result.restaurants.length));
            } else if (state.state == ResultState.noData) {
              return SliverList(
                  delegate: SliverChildListDelegate(
                      [Center(child: Text(state.message))]));
            } else if (state.state == ResultState.error) {
              return SliverList(
                  delegate: SliverChildListDelegate(
                      [Center(child: Text(state.message))]));
            } else {
              return SliverList(
                  delegate:
                      SliverChildListDelegate([const Center(child: Text(''))]));
            }
          })
        ],
      ))),
    );
  }
}
