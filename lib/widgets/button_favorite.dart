import 'package:final_submission/data/models/restaurant_list_model.dart';
import 'package:final_submission/providers/db_provider.dart';
import 'package:final_submission/themes/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonFavorite extends StatefulWidget {
  final Restaurant restaurant;

  const ButtonFavorite({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<ButtonFavorite> createState() => _ButtonFavoriteState();
}

class _ButtonFavoriteState extends State<ButtonFavorite> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorite(widget.restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;

            return isFavorite
                ? FloatingActionButton(
                    onPressed: () =>
                        provider.removeFavorite(widget.restaurant.id),
                    backgroundColor: Colors.white70,
                    child: Icon(CupertinoIcons.heart_circle,
                        color: Colors.red, size: Dimensions.icon_35),
                  )
                : FloatingActionButton(
                    onPressed: () => provider.addFavorite(widget.restaurant),
                    backgroundColor: Colors.white30,
                    child: Icon(CupertinoIcons.heart_circle,
                        size: Dimensions.icon_35));
          });
    });
  }
}
