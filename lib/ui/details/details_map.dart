import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handover/service_locater/navigator_service.dart';

import '../../bloc/details_bloc/details_bloc.dart';
import '../../data/firebaseRepo.dart';
import '../../data/model/notification_type.dart';
import '../../firebase_options.dart';
import '../../service_locater/service_locater.dart';
import 'component/map_widget.dart';

String parcelID = "KsTjmkqSk0qABQlieLK5";

class DetailsMapWidget extends StatefulWidget {
  static const routeName = "/DetailsMapWidget";

  const DetailsMapWidget({Key? key}) : super(key: key);

  @override
  State<DetailsMapWidget> createState() => _DetailsMapWidgetState();
}

class _DetailsMapWidgetState extends State<DetailsMapWidget> {
  final MapDetailsBloc? bloc = MapDetailsBloc();

  final service = FlutterBackgroundService();

  // MapDetailsBloc get bloc => _bloc ??= MapDetailsBloc();
  NotificationType type = NotificationType.nearPickup;

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    // service.stopSelf();
    int index = 0;
    String state = "pickup";

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    final String jsonString =
        await rootBundle.loadString('assets/json/directions_response1.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    DartPluginRegistrant.ensureInitialized();

    FirebaseRepo()
        .parcelListRef
        .doc(parcelID)
        .snapshots()
        .listen((event) async {
      final step = jsonMap[event.data()!.state!]["routes"][0]["legs"][0]
          ["steps"][event.data()!.index]["endLocation"]["latLng"];

      service.invoke(
        'update',
        {
          "lat_lng": LatLng(step["latitude"], step["longitude"]),
        },
      );
    });

    // if (service is AndroidServiceInstance) {
    //   service.on('setAsForeground').listen((event) {
    //     service.setAsForegroundService();
    //   });
    //
    //   service.on('setAsBackground').listen((event) {
    //     service.setAsBackgroundService();
    //   });
    // }

    service.on('stopService').listen((event) {
      print("HI stop self service");
      service.stopSelf();
    });

    Timer.periodic(const Duration(seconds: 2), (timer) async {
      index += 1;
      Map<String, dynamic> updateObject = {"index": index};
      final List<dynamic> list =
          jsonMap[state]["routes"][0]["legs"][0]["steps"];
      if (index >= list.length) {
        if (state == "pickup") {
          index = 0;
          state = "delivery";
          updateObject["index"] = index;
          updateObject["state"] = "delivery";
          // return;
        } else {
          service.stopSelf();
          return;
        }
      }

      await FirebaseRepo().parcelListRef.doc(parcelID).update(updateObject);
    });
  }

  @override
  void initState() {
    initializeService().then((value) => log("done initializeService"));
    FlutterBackgroundService().on('update').listen((event) {
      LatLng latLng = LatLng(event!["lat_lng"][0], event["lat_lng"][1]);
      if (mounted) {
        bloc?.add(ValidatePushNotificationEvent(
          type: type,
          startPosition: (latLng),
          endPosition: generateEndPosition(),
        ));
      } else {
        print("HERE");
      }
    });
    log("FINEISh");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await disposeService();
        sl<NavigationService>().goBack();
        return Future.value(false);
      },
      child: BlocProvider<MapDetailsBloc>(
        create: (_) {
          return bloc!;
        },
        child: Scaffold(
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 100),
                child: MapWidget(
                  destination: buildDestination(),
                  driverInitialLocation: buildDriverInitialLocation(),
                  parcelLocation: buildParcelLocation(),
                  updateTypeCallback: (NotificationType type) {
                    this.type = type;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LatLng buildDestination() => const LatLng(30.065766099999998, 31.485611);

  LatLng buildParcelLocation() =>
      const LatLng(30.059682499999997, 31.324370499999997);

  LatLng buildDriverInitialLocation() =>
      const LatLng(30.000275400000003, 31.445691);

  Future<void> initializeService() async {
    // service.
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        autoStartOnBoot: false,
        isForegroundMode: true,
        // : 1,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    service.startService();
  }

  @pragma('vm:entry-point')
  bool onIosBackground(ServiceInstance service) {
    WidgetsFlutterBinding.ensureInitialized();
    print('FLUTTER BACKGROUND FETCH');
    return true;
  }

  @override
  void dispose() {
    disposeService();
    super.dispose();
  }

  Future<void> disposeService() async {
    var isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke("stopService");
    }
  }

  generateEndPosition() {
    switch (type) {
      case NotificationType.nearPickup:
      case NotificationType.pickedUp:
        return buildParcelLocation();
      case NotificationType.nearDelivery:
      case NotificationType.delivered:
        return buildDestination();
    }
  }
}
