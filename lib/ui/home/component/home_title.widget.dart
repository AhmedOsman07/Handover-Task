import 'package:flutter/material.dart';
import 'package:handover/shared/app_constants/app_numbers.dart';

class HomeTitleWidget extends StatelessWidget {
  const HomeTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppNumbers.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Ahmed',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1),
          ),
          Text(
            'Handover helps in organising & tracking parcels.',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
