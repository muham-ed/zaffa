import 'package:flutter/material.dart';
import 'package:zaffa_app/core/constants/app_colors.dart';

class GiftSender extends StatelessWidget {
  final String receiverName;

  const GiftSender({super.key, required this.receiverName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Send Gift to $receiverName'),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: [
            _buildGiftItem(Icons.card_giftcard, 'Box', '10'),
            _buildGiftItem(Icons.favorite, 'Heart', '50'),
            _buildGiftItem(Icons.star, 'Star', '100'),
            _buildGiftItem(Icons.diamond, 'Diamond', '500'),
            _buildGiftItem(Icons.rocket_launch, 'Rocket', '1000'),
            _buildGiftItem(Icons.celebration, 'Party', '2000'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildGiftItem(IconData icon, String name, String price) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.primary, size: 30),
        Text(name, style: const TextStyle(fontSize: 12)),
        Text('💎 $price', style: const TextStyle(fontSize: 10, color: Colors.orange)),
      ],
    );
  }
}
