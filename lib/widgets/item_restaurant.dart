import 'package:final_submission/common/navigation.dart';
import 'package:final_submission/data/models/restaurant_list_model.dart';
import 'package:final_submission/pages/detail_screen.dart';
import 'package:final_submission/widgets/button_favorite.dart';
import 'package:flutter/material.dart';

import '../themes/dimensions.dart';

class ItemRestaurant extends StatefulWidget {
  final Restaurant restaurant;

  const ItemRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<ItemRestaurant> createState() => _ItemRestaurantState();
}

class _ItemRestaurantState extends State<ItemRestaurant> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigation.intentWithData(DetailScreen.routeName, widget.restaurant),
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
                    tag: widget.restaurant.pictureId,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radius_20),
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/small/${widget.restaurant.pictureId}",
                        fit: BoxFit.cover,
                        height: 250,
                        width: 125.0,
                        repeat: ImageRepeat.noRepeat,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.width_15),
                  Expanded(
                    child: Stack(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.restaurant.name,
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
                              Text(widget.restaurant.city,
                                  style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: Dimensions.height_10),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(
                                    widget.restaurant.rating.toInt(), (index) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18.0,
                                  );
                                }),
                              ),
                              SizedBox(width: Dimensions.font_10),
                              Text(widget.restaurant.rating.toString()),
                              SizedBox(width: Dimensions.font_10),
                              Text("Rating",
                                  style: Theme.of(context).textTheme.subtitle2)
                            ],
                          )
                        ],
                      ),
                    ]),
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
