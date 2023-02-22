part of 'details_bloc.dart';

@immutable
abstract class MapDetailsEvent {}


class ValidatePushNotificationEvent extends MapDetailsEvent {
  final LatLng startPosition;
  final LatLng endPosition;
  final NotificationType type;

  ValidatePushNotificationEvent({
    required this.startPosition,
    required this.endPosition,
    required this.type,
  });
}
