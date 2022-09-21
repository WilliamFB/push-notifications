import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:push_notifications_test/notification_service.dart';

import 'custom_notification.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('token: $token');
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        _notificationService.showNotification(
          CustomNotification(
            id: 1,
            title: 'Title Firebase',
            body: 'Body Firebase',
            payload: 'Firebase',
          ),
        );
      }
    });
  }
}
