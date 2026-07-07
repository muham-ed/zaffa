import 'dart:async';
import 'package:flutter/material.dart';

// محاكاة اتصال WebSocket للشات المباشر
class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  bool _isConnected = false;
  final List<Function(String)> _messageListeners = [];
  Timer? _simulationTimer;

  // الاتصال بالسيرفر
  void connect() {
    if (_isConnected) return;
    _isConnected = true;
    debugPrint('🟢 Socket connected');

    // محاكاة استقبال رسائل واردة كل 3 ثواني
    _simulationTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_isConnected) {
        timer.cancel();
        return;
      }
      final mockMessages = [
        '🎤 Sara joined the room',
        '💬 Ahmed: Hello everyone!',
        '🎁 Layla sent a gift to Mohamed',
        '👋 John left the room',
        '🎵 Music Lovers room is now live!',
      ];
      final randomMessage = mockMessages[DateTime.now().second % mockMessages.length];
      for (var listener in _messageListeners) {
        listener(randomMessage);
      }
    });
  }

  // قطع الاتصال
  void disconnect() {
    _isConnected = false;
    _simulationTimer?.cancel();
    debugPrint('🔴 Socket disconnected');
  }

  // إرسال رسالة
  void sendMessage(String message) {
    if (!_isConnected) {
      debugPrint('⚠️ Cannot send message: not connected');
      return;
    }
    debugPrint('📤 Sent: $message');
    // في التطبيق الحقيقي، هنا يتم إرسال الرسالة عبر WebSocket حقيقي
  }

  // الاستماع للرسائل الواردة
  void onMessage(Function(String) callback) {
    _messageListeners.add(callback);
  }

  // إزالة المستمع
  void removeListener(Function(String) callback) {
    _messageListeners.remove(callback);
  }

  // الحصول على حالة الاتصال
  bool get isConnected => _isConnected;
}
