import 'package:flutter/material.dart';

class ResultItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;
  final VoidCallback? onTap;   // ← هذا المتغير الجديد للضغط

  const ResultItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375; // تصميم أساسي 375px

    final double iconSize = 48 * scale.clamp(0.85, 1.15);
    final double fontSizeTitle = 13 * scale.clamp(0.9, 1.1);
    final double fontSizeSubtitle = 11 * scale.clamp(0.9, 1.1);
    final double fontSizeStatus = 10 * scale.clamp(0.9, 1.1);
    final double padding = 14 * scale.clamp(0.9, 1.2);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1C1F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha:0.05)),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2023),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: statusColor, size: iconSize * 0.55),
            ),

            const SizedBox(width: 12),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeTitle,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: fontSizeSubtitle,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Status + Arrow
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: fontSizeStatus,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 20 * scale.clamp(0.9, 1.2),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}