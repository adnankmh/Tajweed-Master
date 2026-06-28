// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  Future<bool> initialize() async => true;

  Future<bool> requestPermission() async {
    if (!html.Notification.supported) return false;
    final permission = await html.Notification.requestPermission();
    return permission == 'granted';
  }

  Future<void> showTest(String title, String body) async {
    if (html.Notification.supported && html.Notification.permission == 'granted') {
      html.Notification(title, body: body, icon: 'icons/Icon-192.png');
    }
  }

  Future<void> saveDailyReminder(int hour, int minute) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('daily_reminder_hour', hour);
    await prefs.setInt('daily_reminder_minute', minute);
  }
}
