import 'dart:io';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/random_string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  final FlutterLocalNotificationsPlugin flutterlocalnotificationplugin =
      new FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseMessagingService() {
    //initializing setting
    var android = AndroidInitializationSettings('@mipmap/launcher_icon');
    var ios = DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: android, iOS: ios);
    flutterlocalnotificationplugin.initialize(initializationSettings);
  }

  sendNotification() {
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((event) {
      final message = event.data;
      showNotification(message['data']['title'], message['data']['body']);
      return;
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      if (Platform.isIOS) return null;
      myBackgroundMessageHandler(message.data);
    });
  }

  // TOP-LEVEL or STATIC function to handle background messages
  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    showNotification(message['data']['title'], message['data']['body']);
    return Future<void>.value();
  }

  static showNotification(String title, String body) async {
    FlutterLocalNotificationsPlugin flutterlocalnotificationplugin =
        new FlutterLocalNotificationsPlugin();
    var androidinit = AndroidInitializationSettings('@mipmap/launcher_icon');
    var ios = DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidinit, iOS: ios);
    flutterlocalnotificationplugin.initialize(initializationSettings);

    var android = AndroidNotificationDetails(
      title + randomNumeric(4).toString(),
      title + randomNumeric(4).toString(),
      subText: body,
    );
    var iOS = DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    new Future.delayed(Duration.zero, () {
      if (body.startsWith("https://firebasestorage.googleapis.com")) {
        body = "Notice with content attached";
      }
      flutterlocalnotificationplugin.show(
          int.parse(randomNumeric(4)), title, body, platform);
    });
  }

  void storeTokenintoDatabase() async {
    _firebaseMessaging.getToken().then((token) {
      final dbref = FirebaseDatabase.instance
          .ref()
          .child('institute/${AppwriteAuth.instance.instituteid}/');
      if (AppwriteAuth.instance.previlagelevel == 2) {
        dbref
            .child(
                'branches/${AppwriteAuth.instance.branchid}/teachers/${AppwriteAuth.instance.user!.$id}')
            .update({"tokenid": token.toString()});
      } else if (AppwriteAuth.instance.previlagelevel == 3) {
        dbref
            .child(
                'branches/${AppwriteAuth.instance.branchid}/admin/${AppwriteAuth.instance.user!.$id}')
            .update({"tokenid": token.toString()});
      } else if (AppwriteAuth.instance.previlagelevel == 4) {
        dbref
            .child('admin/${AppwriteAuth.instance.user!.$id}')
            .update({"tokenid": token.toString()});
      }
    });
  }
}
