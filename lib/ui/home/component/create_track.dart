import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handover/shared/app_constants/app_numbers.dart';

import '../../../bloc/home_bloc/home_bloc.dart';
class CreateTrackWidget extends StatelessWidget {
  final TextEditingController parcelTextController;

  const CreateTrackWidget({
    super.key,
    required this.parcelTextController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppNumbers.horizontalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 49,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    controller: parcelTextController,
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12),
                      hintText: "Enter parcel number or scan QR code",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                  padding: const EdgeInsets.all(14),
                  width: 50,
                  height: 49,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.qr_code))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                if (parcelTextController.text.isNotEmpty) {
                  BlocProvider.of<HomeBloc>(context).add(
                      AddTrackEvent(parcelTrackID: parcelTextController.text));
                }
              },
              style: Theme.of(context).textButtonTheme.style,
              child: Text(
                'Track parcel',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

