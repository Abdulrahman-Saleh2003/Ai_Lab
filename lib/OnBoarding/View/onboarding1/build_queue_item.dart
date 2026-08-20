import 'package:ai_lab/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class BuildQueueItem extends StatelessWidget {
  const BuildQueueItem({
    super.key,
    required this.vialId,
    required this.test,
    required this.status,
    required this.isActive,
  });

  final String vialId;
  final String test;
  final String status;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 680 || size.width < 360;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 14),
      decoration: BoxDecoration(
        color: const Color(0xFF282A2D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon
          Container(
            width: isSmallScreen ? 42 : 48,
            height: isSmallScreen ? 42 : 48,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF00D2FF).withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.inventory_2,
              color: isActive ? AppMyColor.blueColor : AppMyColor.whiteApp,
              size: isSmallScreen ? 22 : 26,
            ),
          ),
          const SizedBox(width: 12),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vial ID: $vialId',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 11 : 12,
                    color: isActive ? AppMyColor.blueColor : AppMyColor.whiteApp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 3),
                Text(
                  test,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 10.5 : 10,
                    color: AppMyColor.whiteApp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Status Badge
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 8 : 10,
                vertical: isSmallScreen ? 4 : 5,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF00D2FF).withValues(alpha: 0.2)
                    : Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status.toUpperCase(),
                style: TextStyle(
                  fontSize: isSmallScreen ? 9.5 : 10,
                  fontWeight: FontWeight.bold,
                  color: isActive ? AppMyColor.blueColor : AppMyColor.whiteApp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
