import 'package:shared_preferences/shared_preferences.dart';

class CurrencyService {
  static const String _coinsKey = 'user_coins';

  // حفظ الرصيد
  Future<void> saveCoins(int coins) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_coinsKey, coins);
  }

  // استرجاع الرصيد
  Future<int> getCoins() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_coinsKey) ?? 100; // 100 عملة هدية للمستخدم الجديد
  }

  // إضافة عملات (مثلاً بعد شراء أو ربح)
  Future<int> addCoins(int amount) async {
    int current = await getCoins();
    int newBalance = current + amount;
    await saveCoins(newBalance);
    return newBalance;
  }

  // خصم عملات (عند شراء هدية أو خدمة)
  Future<bool> deductCoins(int amount) async {
    int current = await getCoins();
    if (current >= amount) {
      await saveCoins(current - amount);
      return true;
    }
    return false; // رصيد غير كافٍ
  }
}