import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../common/routes.dart';
import '../models/database_model/last_read_table.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) async {
      final payload = details.payload;

      if (payload != null) {
        debugPrint('notification payload : $payload');
      }
      selectNotificationSubject.add(payload ?? '');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, int id,
      {LastReadTable? lastReadTable}) async {
    var channelId = '01';
    var channelName = 'channel_01';
    var channelDescription = 'al-qur\'an news channel';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    var titleNotification = '<b>Al-Qur\'an evo<b>';
    var payload = {};
    var titleNews = "Ayo mulai mengaji bersama kami \u{1F496}";
    if (lastReadTable != null) {
      payload = lastReadTable.toJson();
      titleNews =
          "Reminder untuk bacaan terakhir anda, Surat ${payload['surah_name']} ayat : ${payload['ayat']}\nAyo lanjutkan \u{1F496}";
    }

    await flutterLocalNotificationsPlugin.show(
      id,
      titleNotification,
      titleNews,
      platformChannelSpecifics,
      payload: lastReadTable == null ? null : jsonEncode(payload),
    );
  }

  void configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((payload) async {
      if (payload != '') {
        var data = LastReadTable.fromMap(json.decode(payload));
        var suratNumber = data.number;
        Navigation.intentWithData(detailPageRoutes, arguments: suratNumber);
      }
    });
  }
}
