import 'package:zaffa_app/data/models/chat_model.dart';
import 'package:zaffa_app/data/models/message_model.dart';
import 'package:zaffa_app/data/models/user_model.dart';

class ChatService {
  // بيانات وهمية للمحادثات
  static final List<ChatModel> _mockChats = [
    ChatModel(
      id: '1',
      otherUser: UserModel(
        id: '2',
        name: 'Sara',
        email: 'sara@example.com',
        profileImage: 'https://i.pravatar.cc/150?img=2',
      ),
      lastMessage: MessageModel(
        id: 'm1',
        senderId: '2',
        receiverId: '1',
        text: 'Hey, how are you doing?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
      ),
      unreadCount: 2,
    ),
    ChatModel(
      id: '2',
      otherUser: UserModel(
        id: '3',
        name: 'Mohamed',
        email: 'mohamed@example.com',
        profileImage: 'https://i.pravatar.cc/150?img=3',
      ),
      lastMessage: MessageModel(
        id: 'm2',
        senderId: '3',
        receiverId: '1',
        text: 'See you in the room!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: true,
      ),
      unreadCount: 0,
    ),
  ];

  // الحصول على قائمة المحادثات
  Future<List<ChatModel>> getChats(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockChats;
  }

  // الحصول على رسائل محادثة معينة
  Future<List<MessageModel>> getMessages(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      MessageModel(
        id: 'm1',
        senderId: '2',
        receiverId: '1',
        text: 'Hello!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      MessageModel(
        id: 'm2',
        senderId: '1',
        receiverId: '2',
        text: 'Hi Sara!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      MessageModel(
        id: 'm3',
        senderId: '2',
        receiverId: '1',
        text: 'Hey, how are you doing?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];
  }

  // إرسال رسالة جديدة (محاكاة)
  Future<MessageModel> sendMessage(
      String chatId, String senderId, String receiverId, String text) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      timestamp: DateTime.now(),
      isRead: false,
    );
  }

  // وضع علامة "مقروء" على الرسائل
  Future<void> markAsRead(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // في التطبيق الحقيقي، يتم تحديث قاعدة البيانات
  }
}