class NotificationService {
  Future<bool> initialize() async => true;
  Future<bool> requestPermission() async => true;
  Future<void> showTest(String title, String body) async {}
  Future<void> saveDailyReminder(int hour, int minute) async {}
}
