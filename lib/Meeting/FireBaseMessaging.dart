import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

class FirebaseMessagingService{
   static FlutterLocalNotificationsPlugin flutterlocalnotificationplugin=new FlutterLocalNotificationsPlugin();
   final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
   
   FirebaseMessagingService(){
     
      //initializing setting
      var android= AndroidInitializationSettings('@mipmap/ic_launcher');
      var ios=IOSInitializationSettings();
      var initializationSettings=InitializationSettings(android, ios);
      flutterlocalnotificationplugin.initialize(initializationSettings);

   }

  sendNotification(){
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('AppPushs onMessage : $message');
         _showNotification(message['data']['title'],message['data']['body']);
        return;
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) {
        print('AppPushs onResume : $message');
        if (Platform.isIOS) {
           _showNotification(message['data']['title'],message['data']['body']);
        }
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('AppPushs onLaunch : $message');
        return;
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound:true, badge: true, alert: true)
    );
    
    
  }
 // TOP-LEVEL or STATIC function to handle background messages
  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    print('AppPushs myBackgroundMessageHandler : $message');
     _showNotification(message['data']['title'],message['data']['body']);
    return Future<void>.value();
  }

 

  static _showNotification(String title, String body) async{
    FlutterLocalNotificationsPlugin flutterlocalnotificationplugin=new FlutterLocalNotificationsPlugin();
    var androidinit= AndroidInitializationSettings('@mipmap/ic_launcher');
      var ios=IOSInitializationSettings();
      var initializationSettings=InitializationSettings(androidinit, ios);
      flutterlocalnotificationplugin.initialize(initializationSettings);

    var android =AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
    var iOS=IOSNotificationDetails();
    var platform=NotificationDetails(android, iOS);
    new Future.delayed(Duration.zero, () {
      flutterlocalnotificationplugin.show(0, title, body, platform);
    });
    //await flutterlocalnotificationplugin.show(0, title, body, platform);
  }

 

}