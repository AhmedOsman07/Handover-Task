import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/parcel_model.dart';

class FirebaseRepo {
  final parcelListRef = FirebaseFirestore.instance
      .collection('Parcels')
      .withConverter<ParcelModel>(
          fromFirestore: (snapshots, _) {
            final json = snapshots.data()!;
            json["id"] = snapshots.id;
            return ParcelModel.fromJson(json);
          },
          toFirestore: (parcelObject, _) => parcelObject.toJson());
}
