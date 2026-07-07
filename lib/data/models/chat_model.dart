import 'package:zaffa_app/data/models/user_model.dart';
import 'package:zaffa_app/data/models/message_model.dart';

class ChatModel {
  final String id;
  final UserModel otherUser;
  final MessageModel? lastMessage;
  final int unreadCount;

  ChatModel({
    required this.id,
    required this.otherUser,
    this.lastMessage,
    this.unreadCount = 0,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      otherUser: UserModel.fromJson(json['otherUser']),
      lastMessage: json['lastMessage'] != null
          ? MessageModel.fromJson(json['lastMessage'])
          : null,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}
