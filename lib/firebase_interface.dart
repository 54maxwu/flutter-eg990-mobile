// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// part 'firebase_log_ext.dart';
//
// FirebaseAnalytics _analytics;
//
// FirebaseMessaging _messaging;
//
// FlutterLocalNotificationsPlugin _localNotificationsPlugin;
//
// StreamController<Map<String, dynamic>> _messageStream;
//
// abstract class FirebaseInterface {
//   static set setAnalytics(FirebaseAnalytics ga) => _analytics = ga;
//
//   static set setMessaging(FirebaseMessaging fcm) {
//     _messaging = fcm;
//     _messageStream ??= new StreamController<Map<String, dynamic>>();
//
//     _messaging.getToken().then((token) {
//       debugPrint("fcm token: $token");
//     });
//
//     // Subscribe to a cloud message topic
//     _messaging.subscribeToTopic('test-app');
//     _messaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         _messageStream.sink.add(message);
//         debugPrint("fcm onMessage: $message");
//       },
//     );
//   }
//
//   static FirebaseAnalyticsObserver get getObserver =>
//       FirebaseAnalyticsObserver(analytics: _analytics);
//
//   static bool get isAnalyzing => _analytics != null;
//
//   static FirebaseAnalytics get log => _analytics;
//
//   static Stream<Map<String, dynamic>> get getMessageStream =>
//       _messageStream.stream;
//
//   static closeStream() => _messageStream?.close();
// }
