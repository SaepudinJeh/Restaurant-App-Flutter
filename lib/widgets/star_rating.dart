import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final num? star;

  const StarRating({Key? key, required this.star}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(star!.toInt(), (index) {
        return const Icon(
          Icons.star,
          color: Colors.amber,
          size: 18.0,
        );
      }),
    );
  }
}
