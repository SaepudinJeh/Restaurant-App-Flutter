import 'package:final_submission/providers/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonFavorite extends StatefulWidget {
  const ButtonFavorite({Key? key}) : super(key: key);

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
            ? Positioned(
                right: 20.0,
                bottom: 20.0,
                child: FloatingActionButton(
                    onPressed: () => provider.removeFavorite(),
                    backgroundColor: Colors.white,
                    child:
                        const Icon(CupertinoIcons.heart, color: Colors.pink)))
            : Positioned(
                right: 20.0,
                bottom: 20.0,
                child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    child: const Icon(CupertinoIcons.heart_fill,
                        color: Colors.pink)));
      });
    });
  }
}
