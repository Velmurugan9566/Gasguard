import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService()=> _instance;
  NotificationService._internal();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android:initializationSettingsAndroid,);
    await _notificationsPlugin.initialize(initializationSettings);

  }
  static void showNotification(String title,String body){
    _notificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
            'channelId', 'channelName',
            importance: Importance.high,
           ),
      ),
    );
  }
}
