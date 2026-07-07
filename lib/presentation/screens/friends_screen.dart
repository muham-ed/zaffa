import 'package:flutter/material.dart';
import 'package:zaffa_app/core/constants/app_colors.dart';
import 'package:zaffa_app/data/models/friend_model.dart';
import 'package:zaffa_app/presentation/screens/chat_screen.dart';
import 'package:zaffa_app/services/friend_service.dart';

class FriendsScreen extends StatefulWidget {
  final String userId;
  const FriendsScreen({super.key, required this.userId});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final FriendService _friendService = FriendService();
  List<FriendModel> _friends = [];
  List<FriendModel> _requests = [];
  bool _isLoading = true;
  int _selectedTab = 0; // 0: Friends, 1: Requests

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final friends = await _friendService.getFriends();
    final requests = await _friendService.getPendingRequests();
    setState(() {
      _friends = friends;
      _requests = requests;
      _isLoading = false;
    });
  }

  Future<void> _handleAccept(String friendId) async {
    await _friendService.acceptFriendRequest(friendId);
    _loadData();
  }

  Future<void> _handleReject(String friendId) async {
    await _friendService.rejectFriendRequest(friendId);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _loadData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // تبويبات
                Row(
                  children: [
                    _buildTab('Friends (${_friends.length})', 0),
                    _buildTab('Requests (${_requests.length})', 1),
                  ],
                ),
                Expanded(
                  child: _selectedTab == 0
                      ? _buildFriendsList()
                      : _buildRequestsList(),
                ),
              ],
            ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFriendsList() {
    if (_friends.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text('No friends yet', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Text(
              'Add friends to start chatting!',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _friends.length,
      itemBuilder: (context, index) {
        final friend = _friends[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: friend.user.profileImage != null
                  ? NetworkImage(friend.user.profileImage!)
                  : null,
              child: friend.user.profileImage == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            title: Text(friend.user.name),
            subtitle: Text(friend.user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          chatId: friend.id,
                          otherUser: friend.user,
                          currentUserId: widget.userId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.chat, color: AppColors.primary),
                ),
                IconButton(
                  onPressed: () async {
                    await _friendService.unfriend(friend.id);
                    _loadData();
                  },
                  icon: const Icon(Icons.person_remove, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRequestsList() {
    if (_requests.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add_disabled, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text('No pending requests', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _requests.length,
      itemBuilder: (context, index) {
        final request = _requests[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: request.user.profileImage != null
                  ? NetworkImage(request.user.profileImage!)
                  : null,
              child: request.user.profileImage == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            title: Text(request.user.name),
            subtitle: const Text('Friend request'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _handleAccept(request.id),
                  icon: const Icon(Icons.check, color: Colors.green),
                ),
                IconButton(
                  onPressed: () => _handleReject(request.id),
                  icon: const Icon(Icons.close, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}