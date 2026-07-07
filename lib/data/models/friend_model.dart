import 'package:zaffa_app/data/models/user_model.dart';

enum FriendStatus { pending, accepted, blocked }

class FriendModel {
  final String id;
  final UserModel user;
  final FriendStatus status;
  final DateTime? createdAt;

  FriendModel({
    required this.id,
    required this.user,
    required this.status,
    this.createdAt,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'],
      user: UserModel.fromJson(json['user']),
      status: FriendStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => FriendStatus.pending,
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}