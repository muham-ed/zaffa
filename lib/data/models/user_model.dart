class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  
  // ==== الميزات الإضافية الجديدة ====
  final int xp;
  final int level;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.xp = 0,          // القيمة الافتراضية
    this.level = 1,       // القيمة الافتراضية
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      xp: json['xp'] ?? 0,
      level: json['level'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'xp': xp,
      'level': level,
    };
  }
}