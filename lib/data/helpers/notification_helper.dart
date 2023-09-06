import 'dart:convert';

import 'package:al_quran_apps/common/utils.dart';
import 'package:al_quran_apps/data/models/database_model/last_read_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

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
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      LastReadTable lastReadTable) async {
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
    final payload = lastReadTable.toJson();
    var titleNotification = '<b>Al-Qur\'an evo<b>';
    var titleNews =
        "Reminder untuk bacaan terakhir anda, Surat ${payload['surah_name']} ayat : ${payload['ayat']}, ayo lanjutkan bacaan Al-Qur'an mu";

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: jsonEncode(payload));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((payload) async {
      var data = LastReadTable.fromMap(json.decode(payload));
      var suratNumber = data.number;

      Navigation.intentWithData(route, suratNumber);
    });
  }
}
