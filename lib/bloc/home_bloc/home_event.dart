part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FetchingList extends HomeEvent {}
class AddTrackEvent extends HomeEvent {
  final String parcelTrackID;

  AddTrackEvent({required this.parcelTrackID});
}



