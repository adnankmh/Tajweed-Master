import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<bool> initialize() async {
    if (_initialized) return true;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const macos = DarwinInitializationSettings();
    const linux = LinuxInitializationSettings(defaultActionName: 'Open');
    const settings = InitializationSettings(android: android, iOS: ios, macOS: macos, linux: linux);
    await _plugin.initialize(settings);
    _initialized = true;
    return true;
  }

  Future<bool> requestPermission() async {
    await initialize();
    final androidGranted = await _plugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        true;
    final iosGranted = await _plugin
            .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true) ??
        true;
    final macGranted = await _plugin
            .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true) ??
        true;
    return androidGranted && iosGranted && macGranted;
  }

  Future<void> showTest(String title, String body) async {
    await initialize();
    const androidDetails = AndroidNotificationDetails(
      'tajweed_daily_channel',
      'Tajweed daily reminders',
      channelDescription: 'Daily learning reminders for Tajweed Master Pro',
      importance: Importance.high,
      priority: Priority.high,
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
      macOS: DarwinNotificationDetails(),
      linux: LinuxNotificationDetails(),
    );
    await _plugin.show(1001, title, body, details);
  }

  Future<void> saveDailyReminder(int hour, int minute) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('daily_reminder_hour', hour);
    await prefs.setInt('daily_reminder_minute', minute);
    await showTest('Tajweed Master Pro', 'Daily reminder saved: ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}');
  }
}
