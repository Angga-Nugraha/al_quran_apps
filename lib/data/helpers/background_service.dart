import 'dart:isolate';
import 'dart:ui';

import 'package:al_quran_apps/data/helpers/database_helper.dart';
import 'package:al_quran_apps/data/helpers/notification_helper.dart';
import 'package:al_quran_apps/data/models/database_model/last_read_table.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;

  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  @pragma('vm:entry-point')
  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    final DatabaseHelper databaseHelper = DatabaseHelper();
    debugPrint('Alarm fired');

    var result = await databaseHelper.getLastRead('last read');
    if (result.isEmpty) {
      await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, 0);
    } else {
      final data = LastReadTable.fromMap(result[0]);

      await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, 1,
          lastReadTable: data);
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
