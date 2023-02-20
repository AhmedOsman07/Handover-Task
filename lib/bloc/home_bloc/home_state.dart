part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeListFetched extends HomeState {
  final List<QueryDocumentSnapshot<ParcelModel>> list;
  final bool shouldAppend;

  HomeListFetched(this.list, this.shouldAppend);
}

