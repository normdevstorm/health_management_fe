import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/app_routing.dart';
import 'package:health_management/app/route/route_define.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize Notification Channel
  static Future<void> initializeNotification() async {
    // Android Initialization
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        _handleReceivingAppointmentNotification(details);
      },
      onDidReceiveBackgroundNotificationResponse: (details) => _handleReceivingAppointmentNotification(details),
    );

    // Create Notification Channel
    await _createNotificationChannel();

    // onDidReceiveNotificationResponse and handle this on background
  }

  static void _handleReceivingAppointmentNotification(NotificationResponse details) {
    try {
      int appointmentId = int.parse(details.payload!);
      final BuildContext? context = globalRootNavigatorKey.currentContext;
      if (context != null) {
        GoRouter.of(context).pushNamed(RouteDefine.appointmentDetails,
            pathParameters: {'appointmentId': appointmentId.toString()});
      }
    } catch (e) {
      debugPrint('Error handling notification tap: $e');
    }
  }

  // Create Notification Channel
  static Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      showBadge: true,
    );

    // Create the channel on the device
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Show Notification Method
  static Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    // Notification Details with Channel
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'high_importance_channel', // Must match channel ID
      'High Importance Notifications', // Must match channel name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/launcher_icon',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    // Show the notification
    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // Scheduled Notification
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    required int appointmentId,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      payload: appointmentId.toString(),
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription: 'Scheduled notifications',
          importance: Importance.high,
          icon: '@mipmap/launcher_icon',
          playSound: true,
          audioAttributesUsage: AudioAttributesUsage.alarm,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
