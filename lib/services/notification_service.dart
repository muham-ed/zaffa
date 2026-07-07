import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // قائمة المستمعين للإشعارات
  final List<Function(String)> _listeners = [];

  // إضافة مستمع
  void addListener(Function(String) listener) {
    _listeners.add(listener);
  }

  // إزالة مستمع
  void removeListener(Function(String) listener) {
    _listeners.remove(listener);
  }

  // إرسال إشعار فوري
  void sendNotification(String message) {
    for (var listener in _listeners) {
      listener(message);
    }
  }

  // حفظ الإشعارات السابقة
  Future<void> saveNotification(String message) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    notifications.insert(0, '${DateTime.now().toIso8601String()}|$message');
    if (notifications.length > 50) notifications.removeLast();
    await prefs.setStringList('notifications', notifications);
  }

  // استرجاع الإشعارات السابقة
  Future<List<Map<String, String>>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> raw = prefs.getStringList('notifications') ?? [];
    return raw.map((item) {
      final parts = item.split('|');
      return {
        'time': parts[0],
        'message': parts.length > 1 ? parts[1] : '',
      };
    }).toList();
  }
}
