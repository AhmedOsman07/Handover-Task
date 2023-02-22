import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/model/notification_type.dart';

part 'details_event.dart';

part 'details_state.dart';

class MapDetailsBloc extends Bloc<MapDetailsEvent, DetailsMapState> {
  MapDetailsBloc() : super(DetailsMapInitial()) {
    on<ValidatePushNotificationEvent>(_validatePushNotificationEvent);
  }

  final List<NotificationType> deliveryStatuses = [];

  FutureOr<void> _validatePushNotificationEvent(
      ValidatePushNotificationEvent event,
      Emitter<DetailsMapState> emit) async {
    emit(MapMarkerUpdatedState(latLng: event.startPosition));
    if (!deliveryStatuses.contains(event.type)) {
      var distanceInMeter = Geolocator.distanceBetween(
        event.startPosition.latitude,
        event.startPosition.longitude,
        event.endPosition.latitude,
        event.endPosition.longitude,
      );
      switch (event.type) {
        case NotificationType.nearPickup:
        case NotificationType.nearDelivery:
          if (distanceInMeter <= 5 * 1000) {
            deliveryStatuses.add(event.type);
            emit(SendPushNotificationState(
              nextType: isNearbyPickUp(event)
                  ? NotificationType.pickedUp
                  : NotificationType.delivered,
              msg: isNearbyPickUp(event)
                  ? 'Driver is nearby pickup location'
                  : "driver is nearby delivery location",
              title: isNearbyPickUp(event) ? 'Pickup' : "Delivery",
            ));
          }
          break;
        case NotificationType.pickedUp:
        case NotificationType.delivered:
          if (distanceInMeter <= 100) {
            deliveryStatuses.add(event.type);
            emit(SendPushNotificationState(
              nextType: isPickedUp(event)
                  ? NotificationType.nearDelivery
                  : NotificationType.delivered,
              msg: isPickedUp(event)
                  ? 'Parcel picked up by the driver.'
                  : "Parcel delivered by the driver",
              title: isPickedUp(event) ? 'Pickup up' : "Delivered",
            ));
          }
          break;
      }
    }
  }

  bool isPickedUp(ValidatePushNotificationEvent event) =>
      event.type == NotificationType.pickedUp;

  isNearbyPickUp(ValidatePushNotificationEvent event) =>
      event.type == NotificationType.nearPickup;
}
