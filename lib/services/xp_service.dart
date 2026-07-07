import 'package:shared_preferences/shared_preferences.dart';

class XpService {
  static const String _xpKey = 'user_xp';
  static const String _levelKey = 'user_level';

  // حفظ البيانات محلياً
  Future<void> saveProgress(int xp, int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_xpKey, xp);
    await prefs.setInt(_levelKey, level);
  }

  // استرجاع البيانات
  Future<Map<String, int>> getProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final xp = prefs.getInt(_xpKey) ?? 0;
    final level = prefs.getInt(_levelKey) ?? 1;
    return {'xp': xp, 'level': level};
  }

  // حساب تقدم المستوى الحالي (نسبة مئوية)
  int getProgressPercentage(int xp, int level) {
    int xpNeeded = level * 100;
    return ((xp / xpNeeded) * 100).toInt();
  }
}