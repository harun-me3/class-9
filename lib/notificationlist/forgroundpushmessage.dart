import 'package:class_9th_ncert_all/notificationlist/pushmessage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ForgroundPushMessage {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('---------------------------------------');
        print(payload);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PushMessagePage()),
        );
      }
    });
  }

  //flutter local notification is use for forground heads off notification because by default flutter
  //show heads of notification for background but not for forground show we need this plugin for solve this problem
  //for creating notification channel you have to atleast show notifcation using flutter local notification
  //once display you can configure notification channel

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "NCERT9",
        "NCERT9 channel",
        importance: Importance.max,
        priority: Priority.high,
      ));

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["payload"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
