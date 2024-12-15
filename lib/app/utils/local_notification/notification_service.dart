import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/app_routing.dart';
import 'package:health_management/app/route/route_define.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void notificationTapBackground(
    NotificationResponse notificationResponse) async {
  // Initialize app essentials
  WidgetsFlutterBinding.ensureInitialized();

  // Create a completer to wait for context
  final contextCompleter = Completer<BuildContext>();

  // Setup timer to check for context
  RestartableTimer? timer;
  timer = RestartableTimer(const Duration(milliseconds: 100), () async {
    if (globalRootNavigatorKey.currentContext != null) {
      contextCompleter.complete(globalRootNavigatorKey.currentContext!);
      timer?.cancel();
    } else {
      timer?.reset();
    }
  });

  // Wait for context
  final context = await contextCompleter.future;

  // Handle notification routing
  // Handle background notification
  NotificationService.handleReceivingAppointmentNotification(
      notificationResponse, context);
}

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
      onDidReceiveNotificationResponse: _handleForegroundNotification,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Create Notification Channel
    await _createNotificationChannel();

    // onDidReceiveNotificationResponse and handle this on background
  }

  static Future<void> debugNotification() async {
    await _flutterLocalNotificationsPlugin.show(
      0,
      'Debug Notification',
      'Test notification while app is terminated',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: '123', // Test appointment ID
    );
  }

  static void _handleForegroundNotification(NotificationResponse response) {
    if (response.payload != null) {
      final context = globalRootNavigatorKey.currentState!.context;

      handleReceivingAppointmentNotification(response, context);
    }
  }

  static void handleReceivingAppointmentNotification(
      NotificationResponse details, BuildContext? completeContext) async {
    try {
      int appointmentId = int.parse(details.payload!);
      final navigator = globalRootNavigatorKey.currentState;
      if (navigator != null) {
        final router = GoRouter.of(navigator.context);
        await router.pushReplacementNamed(RouteDefine.appointment,
            queryParameters: {
              "source": "notification",
              "appointmentId": appointmentId.toString()
            });
      } else {
        final router = GoRouter.of(completeContext!);
        router.pushReplacementNamed(RouteDefine.appointment, queryParameters: {
          "source": "notification",
          "appointmentId": appointmentId.toString()
        });
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
