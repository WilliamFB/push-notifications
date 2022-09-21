import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:push_notifications_test/custom_notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();

  initializePlatformNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _localNotifications.initialize(
      const InitializationSettings(
        android: android,
      ),
      onSelectNotification: _onSelectNotification,
    );
  }

  Future<dynamic> _onSelectNotification(String payload) async {
    if (payload != null && payload.isNotEmpty) {
      print('Clicou - payload: $payload');
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
    );

    _localNotifications.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
    );
  }

  checkForNotifications() async {
    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }
}
