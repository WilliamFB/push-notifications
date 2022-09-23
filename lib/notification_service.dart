import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:push_notifications_test/custom_notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();

  initializePlatformNotifications() async {
    // await _setupTimezone();
    await _initializeNotifications();
  }

  // Para agendamento de notificações
  _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifications() async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    await _localNotifications.initialize(
      InitializationSettings(
        android: android,
        iOS: ios,
      ),
      onSelectNotification: _onSelectNotification,
    );
  }

  Future<dynamic> _onSelectNotification(String payload) async {
    if (payload != null && payload.isNotEmpty) {
      // Filtrar por tipo
      // if (payload == 'Mensagens') {
      //   Navigator.pushAndRemoveUntil(
      //     NavigationService.navigatorKey.currentContext,
      //     MaterialPageRoute(builder: (_) => NotificationPage()),
      //     (route) => route.isFirst, // Retorna até a home
      //   );
      // }
    }
  }

  showNotification(CustomNotification notification) {
    final androidDetails = AndroidNotificationDetails(
      'Channel Id',
      'Channel Name',
      'Channel Description',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      color: Colors.blue, // Cor do texto
    );

    final iosDetails = IOSNotificationDetails(
      threadIdentifier: "channel_thread1",
    );

    _localNotifications.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      payload: notification.payload,
    );
  }

  cancelNotifications() => _localNotifications.cancelAll();

  checkForNotifications() async {
    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }
}
