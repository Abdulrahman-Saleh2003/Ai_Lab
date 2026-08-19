import 'package:flutter/material.dart';

class RecentAnalyticsHeader extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback? onViewLedgerPressed;

  const RecentAnalyticsHeader({
    super.key,
    this.title = "RECENT ANALYTICS",
    this.buttonText = "View Ledger",
    this.onViewLedgerPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 20 * scale.clamp(0.9, 1.15),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: onViewLedgerPressed,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: const Color(0xFF00D2FF),
                  fontSize: 13 * scale.clamp(0.9, 1.1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12 * scale.clamp(0.9, 1.2)),
        // هنا يمكنك إضافة قائمة البطاقات (Recent Items)
      ],
    );
  }
}