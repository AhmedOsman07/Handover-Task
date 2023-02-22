import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color color;

  const StarRating(
      {super.key, this.starCount = 5, this.rating = .0, required this.color});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      // ignoreGestures: false,
      itemSize: 50,
      direction: Axis.horizontal,
      // allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.zero,
      itemBuilder: (context, c) {
        return const Icon(
        Icons.star,
        color: Colors.white,
      );
      },
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
