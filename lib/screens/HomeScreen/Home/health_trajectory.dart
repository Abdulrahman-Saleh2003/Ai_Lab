
import 'package:ai_lab/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class HealthTrajectoryWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<double> barHeights;
  final Color accentColor;
  final Color? iconColor;

  const HealthTrajectoryWidget({
    super.key,
    this.title = "Health Trajectory",
    this.subtitle = "Stability index is up by 4.2%",
    required this.barHeights,
    this.accentColor = const Color(0xFF00D2FF),
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    final double barWidth = (22 * scale).clamp(18.0, 28.0);
    final double barMaxHeight = (90 * scale).clamp(70.0, 110.0);
    final double containerPadding = (20 * scale).clamp(16.0, 24.0);
    final double iconContainerSize = (44 * scale).clamp(40.0, 52.0);

    final effectiveIconColor = iconColor ?? AppMyColor.lightLavenderPinkColor;

    return Container(
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E2023), Color(0xFF111317)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00D2FF).withValues(alpha:0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppMyColor.lightLavenderPinkColor.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.query_stats,
                  color: effectiveIconColor,
                  size: 28 * scale.clamp(0.9, 1.2),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 17 * scale.clamp(0.95, 1.15),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12 * scale.clamp(0.9, 1.1),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Responsive Bars
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              barHeights.length,
                  (index) {
                final bool isHighlighted = index == 0 || index == 3 || index == 6;

                // تطبيق النسبة على الارتفاع
                final double height = (barHeights[index] * (barMaxHeight / 90));

                return Container(
                  width: barWidth,
                  height: height,
                  decoration: BoxDecoration(
                    color: isHighlighted ? accentColor : const Color(0xFF1E2023),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(6),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}