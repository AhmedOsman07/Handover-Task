import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late NotificationDetails notificationDetails;
  int id = 1;

  NotificationService() {
    initialize();
  }

  Future initialize() async {
    log("DONE INIT DAWHSA");
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('drawable/ic_launcher');
    final DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
            "1", "handover",
            channelDescription: "test",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            ticker: 'ticker'));
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void showLocalNotification({
    required String title,
    required String message,
  }) {
    flutterLocalNotificationsPlugin.show(id, title, message, notificationDetails,
        payload: "{test:new}");
    id+=1;
  }

  // iOS received local notification
  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    log('notification payload on did receive local notification:');
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) {
    log('notification payload on did receive local notification:');
  }
}
