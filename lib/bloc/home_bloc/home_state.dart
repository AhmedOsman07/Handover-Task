part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeListFetched extends HomeState {
  final List<ParcelModel> list;
  final bool shouldAppend;

  HomeListFetched({required this.list,required this.shouldAppend});
}

