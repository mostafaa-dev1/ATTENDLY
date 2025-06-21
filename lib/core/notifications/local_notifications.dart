import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> initialize() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(settings);
  }

  static Future<void> showNotification() async {
    NotificationDetails androidNotificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
        priority: Priority.max,
        icon: '@mipmap/launcher_icon',
      ),
    );
    await flutterLocalNotificationsPlugin.show(
        1, 'title', 'body', androidNotificationDetails);
  }

  static Future<void> secheduleNotification(
      DateTime dateTime, int id, String title, String body) async {
    NotificationDetails androidNotificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
        priority: Priority.max,
        icon: '@mipmap/launcher_icon',
      ),
    );
    tz.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    log(tz.TZDateTime.now(tz.local).hour.toString());
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.day,
          dateTime.hour, dateTime.minute),
      androidNotificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    log('notification scheduled at ${dateTime.toString()}');
  }

  static Future<void> notification(DateTime startDate, String start, String end,
      String day, int id, String title, String body) async {
    final daysOfWeek = {
      "MON": 1,
      "TUE": 2,
      "WED": 3,
      "THU": 4,
      "FRI": 5,
      "SAT": 6,
      "SUN": 7
    };

    if (daysOfWeek[day] == DateTime.now().weekday &&
        DateTime.now().hour < int.parse(start.split(':')[0])) {
      await secheduleNotification(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(start.split(':')[0]),
            int.parse(start.split(':')[1]),
          ),
          id,
          title,
          body);
      return;
    }
    int daysToAdd = (daysOfWeek[day]! - startDate.weekday) % 7;
    if (daysToAdd <= 0) {
      daysToAdd += 7;
    }
    var nextWeekday = startDate.add(Duration(days: daysToAdd));
    final startDateTime = DateTime(
        nextWeekday.year,
        nextWeekday.month,
        nextWeekday.day,
        int.parse(start.split(':')[0]),
        int.parse(start.split(':')[1]));
    await secheduleNotification(startDateTime, id, title, body);
  }

  static Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static void test() {
    tz.initializeTimeZones();

    log(tz.TZDateTime.now(tz.local).toString());
    log(tz.TZDateTime.now(tz.local).weekday.toString());
    log(DateTime.now().toString());
  }

  // static Future<void> getRealTime() async {
  //   try {
  //     DateTime realTime = await NTP.now();
  //   } catch (e) {

  //   }
  // }
}
