import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final androidImplementation =
    _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
    const settings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(settings:settings);
  }

  //request permission for notifications, returns true if granted
  static Future<bool> requestPermission() async {
    // Use permission_handler for a consistent API across platforms
    // On Android 13+ this will show the system permission dialog if not requested yet
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  //ask for permission if not granted by request permission from the default dialog if when i first open the app i don't allow it, then i can enable it from the profile settings, but if i click on enable notifications and i don't allow it, then i will show the default dialog to allow it
  static Future<void> showPermissionDialog() async {
    final status = await Permission.notification.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      // open app settings so user can enable notifications
      await openAppSettings();
    } else if (status.isRestricted) {
      // on iOS restricted - still open settings
      await openAppSettings();
    } else if (status.isLimited) {
      // iOS limited, nothing to do
    } else if (status.isGranted) {
      // already granted, nothing to do
    }

  }





  static Future<void> showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      icon: "@mipmap/ic_launcher",
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
   id:    0,
      title: 'Notifications Enabled',
      body: 'You will now receive notifications',
    notificationDetails:  details,
    );
  }
}