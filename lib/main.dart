import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'src/app.dart';
import 'src/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await scheduleNotifications();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black.withOpacity(0.002),
    ),
  );
  runApp(const PaisaApp());
}

Future<void> scheduleNotifications() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin()
        ..initialize(const InitializationSettings(
          android: AndroidInitializationSettings('app_icon'),
        ));
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Add Expenses',
    'Add your expenses for the day!!',
    tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1)),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
      ),
    ),
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}
