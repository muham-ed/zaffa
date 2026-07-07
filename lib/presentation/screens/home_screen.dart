import 'package:flutter/material.dart';
import 'package:zaffa_app/core/themes/app_theme.dart';
import 'package:zaffa_app/data/models/room_model.dart';
import 'package:zaffa_app/data/models/user_model.dart';
import 'package:zaffa_app/presentation/screens/room_screen.dart';
import 'package:zaffa_app/presentation/screens/notifications_screen.dart';
import 'package:zaffa_app/presentation/screens/admin_dashboard_screen.dart';
import 'package:zaffa_app/presentation/screens/shop_screen.dart';
import 'package:zaffa_app/presentation/screens/friends_screen.dart';
import 'package:zaffa_app/presentation/screens/chat_list_screen.dart';
import 'package:zaffa_app/presentation/screens/profile_screen.dart';
import 'package:zaffa_app/presentation/widgets/level_badge.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<RoomModel> _rooms = const [
    RoomModel(
      id: '1',
      name: '🎤 Music Lovers',
      category: 'Music',
      participants: 42,
      isLive: true,
    ),
    RoomModel(
      id: '2',
      name: '💻 Tech Talk',
      category: 'Technology',
      participants: 28,
      isLive: true,
    ),
    RoomModel(
      id: '3',
      name: '📚 Book Club',
      category: 'Education',
      participants: 15,
      isLive: false,
    ),
    RoomModel(
      id: '4',
      name: '🎮 Gamers Lounge',
      category: 'Gaming',
      participants: 56,
      isLive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentPage(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return _buildExploreContent();
      case 2:
        return ChatListScreen(userId: widget.user.id);
      case 3:
        return ProfileScreen(user: widget.user);
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildExploreContent() {
    return const Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.explore_outlined, size: 80, color: Colors.white24),
            SizedBox(height: 16),
            Text(
              'Explore Coming Soon',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return CustomScrollView(
      slivers: [
        // AppBar مخصص
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryPurple, AppTheme.secondaryPurple],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Z',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'affa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              // زر الإشعارات
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                iconSize: 24,
              ),
              // زر لوحة التحكم
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminDashboardScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.dashboard_outlined, color: Colors.white),
                iconSize: 24,
              ),
              LevelBadge(user: widget.user),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.secondaryPurple),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: widget.user.profileImage != null
                      ? NetworkImage(widget.user.profileImage!)
                      : null,
                  child: widget.user.profileImage == null
                      ? const Icon(Icons.person, size: 18)
                      : null,
                ),
              ),
            ],
          ),
        ),
        // قائمة الغرف
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList.separated(
            itemCount: _rooms.length,
            itemBuilder: (context, index) {
              final room = _rooms[index];
              return _buildRoomCard(context, room);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
          ),
        ),
        // خلايا إضافية
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildActionCard(context, index),
              childCount: 4,
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
      ],
    );
  }

  Widget _buildRoomCard(BuildContext context, RoomModel room) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoomScreen(room: room)),
          );
        },
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primaryPurple, AppTheme.secondaryPurple],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.mic_none_rounded, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.people_outline, color: Colors.white54, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${room.participants} • ${room.category}',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (room.isLive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, int index) {
    final List<Map<String, dynamic>> actions = [
      {
        'icon': Icons.shopping_bag_outlined,
        'label': 'المتجر',
        'color': AppTheme.secondaryPurple,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ShopScreen()),
          );
        },
      },
      {
        'icon': Icons.people_outline_rounded,
        'label': 'الأصدقاء',
        'color': Colors.blueAccent,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FriendsScreen(userId: widget.user.id)),
          );
        },
      },
      {
        'icon': Icons.sports_esports_outlined,
        'label': 'الألعاب',
        'color': Colors.greenAccent,
        'onTap': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🎮 جاري تحميل الألعاب...'),
              backgroundColor: Colors.greenAccent,
            ),
          );
        },
      },
      {
        'icon': Icons.auto_awesome_outlined,
        'label': 'الفعاليات',
        'color': Colors.orangeAccent,
        'onTap': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🎉 الفعاليات قريباً!'),
              backgroundColor: Colors.orangeAccent,
            ),
          );
        },
      },
    ];

    final action = actions[index];
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: (action['color'] as Color).withValues(alpha: 0.1),
        ),
      ),
      child: InkWell(
        onTap: action['onTap'] as VoidCallback,
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (action['color'] as Color).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                action['icon'] as IconData,
                color: action['color'] as Color,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              action['label'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPurple.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppTheme.secondaryPurple,
        unselectedItemColor: Colors.white38,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'اكتشف',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'المحادثات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'الملف',
          ),
        ],
      ),
    );
  }
}
