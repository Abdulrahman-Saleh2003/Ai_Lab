import 'package:ai_lab/core/constant/app_size.dart';
import 'package:flutter/material.dart';

class BuildIntelligenceCard extends StatelessWidget {
  const BuildIntelligenceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String desc;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(20 * scale),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔷 Icon Box
          Container(
            padding: EdgeInsets.all(14 * scale),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14 * scale),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32 * scale,
            ),
          ),

          SizedBox(width: 20 * scale),

          // 📝 Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 8 * scale),

                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.grey,
                    height: 1.5,
                    fontSize: 14 * scale,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}