import 'dart:io' show Platform;
import 'dart:ui' show Color;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_eg990_mobile/core/mobx_store_export.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:super_enum/super_enum.dart';

part 'firebase_log_ext.dart';

FirebaseAnalytics _analytics;

FirebaseMessaging _messaging;

FlutterLocalNotificationsPlugin _localNotificationsPlugin;

StreamController<Map<String, dynamic>> _messageStream;

abstract class FirebaseInterface {
  static set setAnalytics(FirebaseAnalytics ga) => _analytics = ga;

  static set setMessaging(FirebaseMessaging fcm) {
    _messaging = fcm;
    _messageStream ??= new StreamController<Map<String, dynamic>>();

    _localNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    final initializationSettingsAndroid =
        new AndroidInitializationSettings('icon_notif');
    final initializationSettingsIOS = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    Future.sync(() => initializeLocalNotify(initializationSettings));

    _messaging.getToken().then((token) {
      debugPrint("fcm token: $token");
    });

    // Subscribe to a cloud message topic
    _messaging.subscribeToTopic('test-app');
    _messaging.configure(
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        _messageStream.sink.add(message);
        debugPrint("fcm onMessage: $message");
      },
    );
  }

  static FirebaseAnalyticsObserver get getObserver =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  static bool get isAnalyzing => _analytics != null;

  static FirebaseAnalytics get log => _analytics;

  static Stream<Map<String, dynamic>> get getMessageStream =>
      _messageStream.stream;

  static askPermission() async =>
      await _messaging?.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false),
      );

  static initializeLocalNotify(
          InitializationSettings initializationSettings) async =>
      await _localNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: onSelectNotification,
      );

  static closeStream() => _messageStream?.close();
}

Future<void> onSelectNotification(String payload) async {
  debugPrint('onSelectNotification payload: $payload');
  // await Navigator.push(
  //   context,
  //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  // );
  return Future<void>.value();
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  debugPrint("myBackgroundMessageHandler message: $message");
  int msgId = int.tryParse(message["data"]["msgId"].toString()) ?? 0;
  debugPrint("msgId $msgId");
  //channel id and name should be the same in Application.kt
  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'fcm_default_channel', // channel id = string.xml value
    'General', // channel name = Channel name under app settings
    "All notifications", // channel description
    importance: Importance.max,
    priority: Priority.high,
    color: const Color(0xffe7c080),
  );
  final iOSPlatformChannelSpecifics = IOSNotificationDetails();
  final platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  _localNotificationsPlugin?.show(
    msgId,
    message["data"]["msgTitle"],
    message["data"]["msgBody"],
    platformChannelSpecifics,
    payload: message["data"]["data"],
  );
  return Future<void>.value();
}
