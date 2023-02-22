import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/parcel_model.dart';

abstract class HomeRepo {
  Future<List<QueryDocumentSnapshot<ParcelModel>>> fetchParcels(
      {required int limit, required int pageNumber});

  Future<ParcelModel>  addTrackEvent(
      {required ParcelModel parcelModel});
}
