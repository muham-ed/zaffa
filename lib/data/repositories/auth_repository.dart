import '../models/user_model.dart';

class AuthRepository {
  static final UserModel _mockUser = UserModel(
    id: '1',
    name: 'Ahmed',
    email: 'ahmed@example.com',
    profileImage: 'https://i.pravatar.cc/150?img=1',
    xp: 450,        // بداية بـ 450 نقطة
    level: 3,       // المستوى 3
  );

  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (password == '123456') {
      return _mockUser;
    } else {
      throw Exception('Invalid email or password');
    }
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // ==== دالة جديدة لإضافة XP للمستخدم ====
  static UserModel addXp(UserModel user, int amount) {
    int newXp = user.xp + amount;
    int newLevel = user.level;
    
    // كل 100 نقطة = مستوى جديد (مثال)
    while (newXp >= newLevel * 100) {
      newXp -= newLevel * 100;
      newLevel++;
    }
    
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      profileImage: user.profileImage,
      xp: newXp,
      level: newLevel,
    );
  }
}