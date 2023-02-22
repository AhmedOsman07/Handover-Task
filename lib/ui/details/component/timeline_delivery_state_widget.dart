import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handover/bloc/details_bloc/details_bloc.dart';
import 'package:handover/data/model/notification_type.dart';
import 'package:handover/shared/app_constants/app_numbers.dart';

class TimelineDeliveryStateWidget extends StatelessWidget {
   TimelineDeliveryStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppNumbers.horizontalPadding),
      child: Wrap(
        children: [
          buildItem(
              isCompleted: isCompleted(
                  context: context, type: NotificationType.nearPickup),
              text: generateString(type: NotificationType.nearPickup)),
          buildItem(
              isCompleted: isCompleted(
                  context: context, type: NotificationType.pickedUp),
              text: generateString(type: NotificationType.pickedUp)),
          buildItem(
              isCompleted: isCompleted(
                  context: context, type: NotificationType.nearDelivery),
              text: generateString(type: NotificationType.nearDelivery)),
          buildItem(
              isCompleted: isCompleted(
                  context: context, type: NotificationType.delivered),
              text: generateString(type: NotificationType.delivered),
              shouldAdd: false),
        ],
      ),
    );
  }

  bool isCompleted({
    required BuildContext context,
    required NotificationType type,
  }) {
    return BlocProvider.of<MapDetailsBloc>(context)
        .deliveryStatuses
        .contains(type);
  }

  String generateString({
    required NotificationType type,
  }) {
    switch (type) {
      case NotificationType.nearPickup:
        return "On the way";
      case NotificationType.nearDelivery:
        return "Near delivery destination";
      case NotificationType.pickedUp:
        return "Picked up delivery";
      case NotificationType.delivered:
        return "Delivered package";
    }
  }

  final double constantValue = 8.0;

  Stack buildItem(
      {required bool isCompleted,
      required String text,
      bool shouldAdd = true}) {
    return Stack(children: <Widget>[
      SizedBox(
        height: constantValue * 4,
        width: double.infinity,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: constantValue * 2.4),
        child: Text(
          text,
          style: TextStyle(
            height: .8,
            color: isCompleted ? Colors.black : Colors.white.withOpacity(0.8),
          ),
        ),
      ),
      if (shouldAdd)
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: constantValue,
          child: Container(
            height: double.infinity,
            width: 1.0,
            color: isCompleted ? Colors.black : Colors.white.withOpacity(0.8),
          ),
        ),
      Positioned(
        top: 0.0,
        left: constantValue / 2,
        child: Container(
          margin: EdgeInsets.only(top: 1),
          height: constantValue,
          width: constantValue,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
      )
    ]);
  }
}
