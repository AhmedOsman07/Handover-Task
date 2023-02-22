import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/parcel_model.dart';
import '../../data/repo/home/home_repo_iml.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepoIml homeRepoIml;
  final int _limit = 10;

  int _pageNumber = 1;

  HomeBloc({required this.homeRepoIml}) : super(HomeInitial()) {
    on<FetchingList>(_fetchTodoList);
    on<AddTrackEvent>(_addTrackEvent);
  }

  void resetPage() {
    _pageNumber = 1;
  }

  FutureOr<void> _fetchTodoList(
      FetchingList event, Emitter<HomeState> emit) async {
    await homeRepoIml
        .fetchParcels(limit: _limit, pageNumber: _pageNumber)
        .then((value) {
      if (value.isNotEmpty) {
        emit(HomeListFetched(
            list: value.map((e) => e.data()).toList(),
            shouldAppend: _pageNumber != 1));
        _pageNumber += 1;
      }
    });
  }

  FutureOr<void> _addTrackEvent(
      AddTrackEvent event, Emitter<HomeState> emit) async {
    final ParcelModel parcelModel = ParcelModel(
        parcelID: event.parcelTrackID,
        state: "pickup",
        index: 0,
        fileName: "directions_response1.json",
        timestamp: DateTime.now().microsecondsSinceEpoch);
    await homeRepoIml.addTrackEvent(parcelModel: parcelModel).then((value) {
      emit(HomeListFetched(list: [(value)], shouldAppend: true));
    });
  }
}
