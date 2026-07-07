import 'package:zaffa_app/data/models/friend_model.dart';
import 'package:zaffa_app/data/models/user_model.dart';

class FriendService {
  // بيانات وهمية للأصدقاء
  static final List<FriendModel> _mockFriends = [
    FriendModel(
      id: 'f1',
      user: UserModel(
        id: '2',
        name: 'Sara',
        email: 'sara@example.com',
        profileImage: 'https://i.pravatar.cc/150?img=2',
      ),
      status: FriendStatus.accepted,
    ),
    FriendModel(
      id: 'f2',
      user: UserModel(
        id: '3',
        name: 'Mohamed',
        email: 'mohamed@example.com',
        profileImage: 'https://i.pravatar.cc/150?img=3',
      ),
      status: FriendStatus.accepted,
    ),
    FriendModel(
      id: 'f3',
      user: UserModel(
        id: '4',
        name: 'Layla',
        email: 'layla@example.com',
        profileImage: 'https://i.pravatar.cc/150?img=4',
      ),
      status: FriendStatus.pending,
    ),
  ];

  // قائمة الأصدقاء المقبولين
  Future<List<FriendModel>> getFriends() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockFriends.where((f) => f.status == FriendStatus.accepted).toList();
  }

  // طلبات الصداقة (المنتظرة)
  Future<List<FriendModel>> getPendingRequests() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockFriends.where((f) => f.status == FriendStatus.pending).toList();
  }

  // إرسال طلب صداقة
  Future<bool> sendFriendRequest(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // محاكاة النجاح
    return true;
  }

  // قبول طلب صداقة
  Future<bool> acceptFriendRequest(String friendId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  // رفض طلب صداقة
  Future<bool> rejectFriendRequest(String friendId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  // إلغاء الصداقة
  Future<bool> unfriend(String friendId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}