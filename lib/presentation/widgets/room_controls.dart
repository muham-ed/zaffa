import 'package:flutter/material.dart';
import 'package:zaffa_app/core/constants/app_colors.dart';

class RoomControls extends StatelessWidget {
  final VoidCallback onMicTap;
  final VoidCallback onMuteTap;
  final VoidCallback onRaiseTap;
  final VoidCallback onGiftTap;
  final VoidCallback onGameTap;

  const RoomControls({
    super.key,
    required this.onMicTap,
    required this.onMuteTap,
    required this.onRaiseTap,
    required this.onGiftTap,
    required this.onGameTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(Icons.mic, 'Mic', onMicTap),
          _buildButton(Icons.mic_off, 'Mute', onMuteTap),
          _buildButton(Icons.handshake, 'Raise', onRaiseTap),
          _buildButton(Icons.card_giftcard, 'Gift', onGiftTap),
          _buildButton(Icons.gamepad, 'Games', onGameTap),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 28),
          color: AppColors.primary,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: AppColors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
