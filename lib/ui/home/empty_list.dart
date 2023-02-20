import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../shared/app_constants/app_colors.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("You don't have any tracked parcels.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2),
    );
  }
}
