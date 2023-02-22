import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../bloc/details_bloc/details_bloc.dart';
import '../../../data/model/notification_type.dart';
import '../../../service_locater/notification_service.dart';
import '../../../service_locater/service_locater.dart';
import '../../../shared/app_constants/app_colors.dart';
import '../../../shared/app_constants/app_numbers.dart';

class MapWidget extends StatefulWidget {
  final LatLng destination;
  final LatLng parcelLocation;
  final LatLng driverInitialLocation;
  final void Function(NotificationType type) updateTypeCallback;

  const MapWidget({
    super.key,
    required this.destination,
    required this.parcelLocation,
    required this.updateTypeCallback,
    required this.driverInitialLocation,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Set<Marker> markers = {}; //markers for google map
  GoogleMapController? _controller;

  GlobalKey mapKey = GlobalKey();
  int numDeltas = 50; //number of delta to devide total distance
  int delay = 50; //milliseconds of delay to pass each delta
  var i = 0;
  double? deltaLat;
  double? deltaLng;

  List<double> position = [];

  Circle? pickupMarker, deliveryMarker;

  @override
  initState() {
    pickupMarker = Circle(
      circleId: const CircleId("parcelLocation"),
      center: widget.parcelLocation,
      radius: AppNumbers.circleRadius,
      strokeColor: AppColors.startLocationStrokeColor,
      fillColor: AppColors.startLocationFilColor,
      strokeWidth: AppNumbers.circleStroke,
    );
    deliveryMarker = Circle(
      circleId: const CircleId("destination"),
      center: widget.destination,
      radius: AppNumbers.circleRadius,
      strokeColor: AppColors.endLocationStrokeColor,
      fillColor: AppColors.endLocationFilColor,
      strokeWidth: AppNumbers.circleStroke,
    );
    position = [
      widget.driverInitialLocation.latitude,
      widget.driverInitialLocation.longitude
    ]; //initial position of moving marker
    addMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapDetailsBloc, DetailsMapState>(
      key: widget.key,
      listener: (context, state) {
        if (state is MapMarkerUpdatedState) {
          _controller?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  state.latLng.latitude,
                  state.latLng.longitude,
                ),
                zoom: 13,
              ),
            ),
          );
          transition([state.latLng.latitude, state.latLng.longitude]);
        } else if (state is SendPushNotificationState) {
          widget.updateTypeCallback(state.nextType);
          sl<NotificationService>()
              .showLocalNotification(title: state.title, message: state.msg);
        }
      },
      child: GoogleMap(
        key: mapKey,
        onMapCreated: (GoogleMapController controller) async {
          _controller = controller;
        },
        initialCameraPosition:
            CameraPosition(target: widget.driverInitialLocation, zoom: 13),
        circles: {
          pickupMarker!,
          deliveryMarker!,
        },
        markers: markers,
      ),
    );
  }

  addMarkers() {
    markers.add(Marker(
        markerId: MarkerId(widget.driverInitialLocation.toString()),
        position: widget.driverInitialLocation));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  transition(result) {
    i = 0;
    deltaLat = (result[0] - position[0]) / numDeltas;
    deltaLng = (result[1] - position[1]) / numDeltas;
    moveMarker();
  }

  moveMarker() {
    position[0] += deltaLat!;
    position[1] += deltaLng!;
    final latLng = LatLng(position[0], position[1]);
    markers = {
      Marker(
        markerId: const MarkerId("driver"),
        position: latLng,
      )
    };
    setState(() {});
    if (i != numDeltas) {
      i++;
      Future.delayed(Duration(milliseconds: delay), () {
        moveMarker();
      });
    }
  }
}
