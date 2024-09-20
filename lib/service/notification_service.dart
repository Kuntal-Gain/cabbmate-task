import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // Initialize settings for Android
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo');

    // Initialize settings for iOS
    var initializationSettingsIos = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    // Combine Android and iOS settings
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIos,
    );

    // Initialize the plugin
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  // Define the notification details (customize as needed)
  NotificationDetails notificationDetails() {
    // Define Android-specific notification details
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'channelId', // Unique ID for the notification channel
      'channelName', // Name for the channel (visible to user)
      channelDescription:
          'This channel is used for important notifications.', // Channel description
      importance: Importance.max, // Importance level
      priority: Priority.high, // Priority level
      showWhen: true, // Show the time the notification was triggered
    );

    // Define iOS-specific notification details
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails();

    // Return platform-specific notification details
    return NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
  }

  // Method to show notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    // Show the notification using the specified details
    return notificationsPlugin.show(id, title, body, notificationDetails(),
        payload: payload);
  }
}
