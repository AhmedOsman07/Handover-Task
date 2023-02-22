import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handover/shared/app_constants/app_numbers.dart';
import 'package:handover/shared/widget/star.dart';

class DeliveredStateWidget extends StatelessWidget {
  const DeliveredStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: AppNumbers.horizontalPadding,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppNumbers.horizontalPadding),
          child: Column(
            children: [
              const StarRating(
                color: Colors.white,
              ),
              const SizedBox(height: AppNumbers.horizontalPadding * 2),
              buildRowTitle(
                  title: "Pickup time", value: "10:00 pm", context: context),
              const SizedBox(
                height: AppNumbers.horizontalPadding / 2,
              ),
              buildRowTitle(
                  title: "Delivery Time", value: "10:00 pm", context: context),
              const SizedBox(
                height: AppNumbers.horizontalPadding,
              ),
              buildRowTitle(title: "Total", context: context),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(left: AppNumbers.horizontalPadding),
              child: Text(
                "\$30.00",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 16),
              ),
            ),
            const Spacer(),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppNumbers.horizontalPadding,
                    vertical: AppNumbers.horizontalPadding / 2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 32 / 3,
                    ),
                    Text(
                      "Submit",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    const Icon(Icons.arrow_forward),
                  ],
                )),
          ],
        ),
        const SizedBox(
          height: AppNumbers.horizontalPadding / 2,
        ),
      ],
    );
  }

  Widget buildRowTitle(
      {required BuildContext context, required String title, String? value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        if (value != null)
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w400)),
      ],
    );
  }
}
