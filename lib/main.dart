import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notifications_test/firebase_messaging_service.dart';
import 'package:push_notifications_test/firebase_options.dart';
import 'package:push_notifications_test/notification_service.dart';

import 'app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: (_) => NotificationService(),
        ),
        Provider<FirebaseMessagingService>(
          create: (context) => FirebaseMessagingService(
            context.read<NotificationService>(),
          ),
        ),
      ],
      child: AppWidget(),
    ),
  );
}
