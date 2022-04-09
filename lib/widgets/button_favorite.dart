import 'package:final_submission/data/models/restaurant_list_model.dart';
import 'package:final_submission/providers/db_provider.dart';
import 'package:final_submission/themes/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonFavorite extends StatefulWidget {
  final Restaurant data;

  const ButtonFavorite({Key? key, required this.data}) : super(key: key);

  @override
  State<ButtonFavorite> createState() => _ButtonFavoriteState();
}

class _ButtonFavoriteState extends State<ButtonFavorite> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(builder: (context, snapshot) {
        var isFavorite = snapshot.data ?? false;

        return isFavorite
            ? IconButton(
                onPressed: () => provider.removeFavorite(widget.data.id),
                icon:
                    Icon(CupertinoIcons.heart_circle, size: Dimensions.icon_24))
            : IconButton(
                onPressed: () => provider.addFavorite(widget.data),
                icon: Icon(CupertinoIcons.heart, size: Dimensions.icon_24));
      });
    });
  }
}
