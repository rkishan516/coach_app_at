import 'dart:io';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/random_string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  final FlutterLocalNotificationsPlugin flutterlocalnotificationplugin =
      new FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FirebaseMessagingService() {
    //initializing setting
    var android = AndroidInitializationSettings('@mipmap/launcher_icon');
    var ios = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android, ios);
    flutterlocalnotificationplugin.initialize(initializationSettings);
  }

  sendNotification() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        showNotification(message['data']['title'], message['data']['body']);
        return;
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) {
        if (Platform.isIOS) {
          showNotification(message['data']['title'], message['data']['body']);
        }
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        return;
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
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
    var ios = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(androidinit, ios);
    flutterlocalnotificationplugin.initialize(initializationSettings);

    var android = AndroidNotificationDetails(
        title + randomNumeric(4).toString(),
        title + randomNumeric(4).toString(),
        body);
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    int notification_id = int.parse(randomNumeric(4));
    new Future.delayed(Duration.zero, () {
      flutterlocalnotificationplugin.show(
          notification_id, title, body, platform);
    });
  }

  void storeTokenintoDatabase() async {
    _firebaseMessaging.getToken().then((token) {
      final dbref = FirebaseDatabase.instance
          .reference()
          .child('institute/${FireBaseAuth.instance.instituteid}/');
      if (FireBaseAuth.instance.previlagelevel == 2) {
        dbref
            .child(
                'branches/${FireBaseAuth.instance.branchid}/teachers/${FireBaseAuth.instance.user.uid}')
            .update({"tokenid": token.toString()});
      } else if (FireBaseAuth.instance.previlagelevel == 3) {
        dbref
            .child(
                'branches/${FireBaseAuth.instance.branchid}/admin/${FireBaseAuth.instance.user.uid}')
            .update({"tokenid": token.toString()});
      } else if (FireBaseAuth.instance.previlagelevel == 4) {
        dbref
            .child('admin/${FireBaseAuth.instance.user.uid}')
            .update({"tokenid": token.toString()});
      }
    });
  }
}
