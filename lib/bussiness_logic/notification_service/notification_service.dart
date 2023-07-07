import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_structure/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  // await NotificationService().displayNotification(message.toMap());
}

class NotificationService {
  Future<void> initializeFcm() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    bool? initialize = await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:onDidReceiveNotificationResponse,
    );
    printLog("initializeFcm()=> $initialize");
    // printLog("get fcm Token()=> ${await getFcmToken()}");

  }

  Future<void> initPushNotificationListeners() async {
    try {
      /// Get IOS Permission
      if (Platform.isIOS) await FirebaseMessaging.instance.requestPermission();

      /// FirebaseMessaging Background Message Handler
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

      /// 1. This method call when app in terminated state and you get a notification
      /// when you click on notification app open from terminated state and you can get notification data in this method
      await FirebaseMessaging.instance
          .getInitialMessage()
          .then((remoteMessage) => initPushNotificationListenersOnMessage);

      /// 2. This method only call when App in foreground it mean app must be opened
      FirebaseMessaging.onMessage
          .listen(initPushNotificationListenersOnMessage);

      /// 3. This method only call when App in background and not terminated(not closed)
      FirebaseMessaging.onMessageOpenedApp
          .listen(initPushNotificationListenersOnMessage);
      printLog("initPushNotificationListeners()=> ");
    } catch (e, t) {
      printLog(e);
      printLog(t);
    }
  }

  Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    printLog("onDidReceiveLocalNotification()=> $id");
    printLog("onDidReceiveLocalNotification()=> $title");
    printLog("onDidReceiveLocalNotification()=> $body");
    printLog("onDidReceiveLocalNotification()=> $payload");
    if (Get.overlayContext != null) {
      showDialog(
        context: Get.overlayContext!,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title ?? ""),
          content: Text(body ?? ""),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () async {
                // Navigator.of(context, rootNavigator: true).pop();
                // await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const SplashScreen(),
                //   ),
                // );
              },
            )
          ],
        ),
      );
    }
  }

  void initPushNotificationListenersOnMessage(RemoteMessage event) {
    displayNotification(event.toMap());
  }



  /// Function to Notification Show.
  Future displayNotification(Map<String, dynamic> message) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'default_notification_channel_id',
      'community_watcher',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await notificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: jsonEncode(message['data']),
    );
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) {
  }
}
