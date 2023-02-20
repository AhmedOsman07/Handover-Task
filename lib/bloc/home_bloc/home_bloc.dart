import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/firebaseRepo.dart';
import '../../data/model/parcel_model.dart';
import '../../data/repo/home/home_repo_iml.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepoIml homeRepoIml;
  final int _limit = 10;

  int _pageNumber = 1;

  HomeBloc({required this.homeRepoIml}) : super(HomeInitial()) {
    on<FetchingList>(fetchTodoList);
  }

  void resetPage() {
    _pageNumber = 1;
  }

  FutureOr<void> fetchTodoList(
      FetchingList event, Emitter<HomeState> emit) async {
    homeRepoIml.fetchParcels(limit: _limit, pageNumber: _pageNumber);
  }
}
