import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebaseRepo.dart';
import '../../model/parcel_model.dart';
import 'home_repo.dart';

class HomeRepoIml extends HomeRepo {
  final FirebaseRepo firebaseRepo;

  HomeRepoIml({required this.firebaseRepo});

  @override
  Future<List<QueryDocumentSnapshot<ParcelModel>>> fetchParcels(
      {required int limit, required int pageNumber}) async {
    return await FirebaseRepo()
        .parcelListRef
        // .limit(limit)
        .endAt([pageNumber * limit])
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) async {
          return Future.value(value.docs);
        });
  }
}
