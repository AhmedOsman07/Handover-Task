part of 'details_bloc.dart';

@immutable
abstract class DetailsMapState {}

class DetailsMapInitial extends DetailsMapState {}

class MapMarkerUpdatedState extends DetailsMapState {
  final LatLng latLng;

  MapMarkerUpdatedState({
    required this.latLng,
  });
}

class SendPushNotificationState extends DetailsMapState {
  final NotificationType nextType;
  final String msg;
  final String title;

  SendPushNotificationState({
    required this.nextType,
    required this.msg,
    required this.title,
  });
}
