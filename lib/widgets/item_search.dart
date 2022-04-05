import 'package:final_submission/data/models/search_restaurant_model.dart';
import 'package:final_submission/pages/detail_screen.dart';
import 'package:flutter/material.dart';

import '../themes/dimensions.dart';

class ItemSearch extends StatelessWidget {
  final SearchRestaurant restaurant;

  const ItemSearch({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, DetailScreen.routeName,
          arguments: restaurant.id),
      child: Container(
        margin: EdgeInsets.all(Dimensions.height_10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: Dimensions.height_15, right: Dimensions.height_15),
              height: 120.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius_20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45.withOpacity(0.2),
                      blurRadius: 2.0,
                      offset: const Offset(0, 4.0),
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: restaurant.pictureId,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radius_20),
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                        fit: BoxFit.cover,
                        height: 250,
                        width: 125.0,
                        repeat: ImageRepeat.noRepeat,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.width_15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(restaurant.name,
                            style: Theme.of(context).textTheme.headline5,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        SizedBox(height: Dimensions.height_15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: Dimensions.icon_24,
                              color: Colors.amberAccent,
                            ),
                            SizedBox(width: Dimensions.font_10),
                            Text(restaurant.city,
                                style: Theme.of(context).textTheme.subtitle2),
                          ],
                        ),
                        SizedBox(height: Dimensions.height_10),
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(restaurant.rating.toInt(),
                                  (index) {
                                return const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18.0,
                                );
                              }),
                            ),
                            SizedBox(width: Dimensions.font_10),
                            Text(restaurant.rating.toString()),
                            SizedBox(width: Dimensions.font_10),
                            Text("Rating",
                                style: Theme.of(context).textTheme.subtitle2)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
