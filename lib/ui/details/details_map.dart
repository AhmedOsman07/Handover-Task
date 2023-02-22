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
import 'package:handover/shared/app_constants/app_colors.dart';

import '../../bloc/details_bloc/details_bloc.dart';
import '../../data/firebaseRepo.dart';
import '../../data/model/notification_type.dart';
import '../../firebase_options.dart';
import '../../service_locater/service_locater.dart';
import '../../shared/app_constants/app_numbers.dart';
import '../../shared/widget/star.dart';
import 'component/delivered_state_widget.dart';
import 'component/map_widget.dart';
import 'component/timeline_delivery_state_widget.dart';

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  int index = 0;
  String parcelID = "KsTjmkqSk0qABQlieLK5";

  String state = "pickup";

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final String jsonString =
      await rootBundle.loadString('assets/json/directions_response1.json');
  Map<String, dynamic> jsonMap = json.decode(jsonString);

  DartPluginRegistrant.ensureInitialized();

  FirebaseRepo().parcelListRef.doc(parcelID).snapshots().listen((event) async {
    final List<dynamic> list = jsonMap[state]["routes"][0]["legs"][0]["steps"];
    if (index < list.length) {
      final step = list[event.data()!.index!]["endLocation"]["latLng"];

      service.invoke(
        'update',
        {
          "lat_lng": LatLng(step["latitude"], step["longitude"]),
        },
      );
    }
  });

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 3), (timer) async {
    index += 2;
    Map<String, dynamic> updateObject = {"index": index};
    final List<dynamic> list = jsonMap[state]["routes"][0]["legs"][0]["steps"];
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
          backgroundColor: AppColors.mainAppColor,
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.only(
                    bottom: (MediaQuery.of(context).size.height * 0.82) / 6),
                child: MapWidget(
                  destination: buildDestination(),
                  driverInitialLocation: buildDriverInitialLocation(),
                  parcelLocation: buildParcelLocation(),
                  updateTypeCallback: (NotificationType type) {
                    this.type = type;
                  },
                ),
              ),
              DraggableScrollableSheet(
                  initialChildSize: 0.25,
                  minChildSize: 0.25,
                  maxChildSize: 0.85,
                  builder: (ctx, controller) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: ListView(
                          shrinkWrap: true,
                          controller: controller,
                          children: [
                            Stack(
                              fit: StackFit.loose,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: BottomSheet(
                                    enableDrag: false,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                      ),
                                    ),
                                    backgroundColor: AppColors.mainAppColor,
                                    onClosing: () {},
                                    builder: (ctx) => AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      padding: const EdgeInsets.only(top: 60),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("John Doe",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(fontSize: 18)),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          BlocBuilder<MapDetailsBloc,
                                              DetailsMapState>(
                                            key: widget.key,
                                            buildWhen: (_, cur) => cur
                                                is SendPushNotificationState,
                                            builder: (context, state) {
                                              return !(bloc?.deliveryStatuses
                                                          .contains(
                                                              NotificationType
                                                                  .delivered) ??
                                                      false)
                                                  ? TimelineDeliveryStateWidget()
                                                  : const DeliveredStateWidget();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CircleAvatar(
                                      radius: 50,
                                      child: Icon(
                                        Icons.person,
                                        size: 80,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    );
                  }),
              Positioned(
                left: AppNumbers.horizontalPadding - 8,
                top: AppNumbers.horizontalPadding,
                child: GestureDetector(
                    onTap: () async {
                      await disposeService();
                      sl<NavigationService>().goBack();
                    },
                    child: const Icon(Icons.arrow_back)),
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
        autoStart: false,
        autoStartOnBoot: false,
        isForegroundMode: true,
        // : 1,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
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

