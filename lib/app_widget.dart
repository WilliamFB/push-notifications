import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_notification.dart';
import 'firebase_messaging_service.dart';
import 'notification_service.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationService>().initializePlatformNotifications();
    context.read<FirebaseMessagingService>().initialize();
  }

  void _notify() async {
    context.read<NotificationService>().showNotification(
          CustomNotification(
            id: 1,
            title: 'title',
            body: 'body',
            payload: 'Click',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _notify,
        child: Icon(Icons.add),
      ),
    );
  }
}
