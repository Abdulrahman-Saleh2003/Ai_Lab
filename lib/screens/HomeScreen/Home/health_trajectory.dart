import 'package:ai_lab/core/constant/app_color.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HealthTrajectoryWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<double> barHeights;
  final Color accentColor;
  final Color? iconColor;

  const HealthTrajectoryWidget({
    super.key,
    this.title,
    this.subtitle,
    required this.barHeights,
    this.accentColor = const Color(0xFF00D2FF),
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    final double barWidth = (22 * scale).clamp(18.0, 28.0);
    final double barMaxHeight = (90 * scale).clamp(70.0, 110.0);
    final double containerPadding = (20 * scale).clamp(16.0, 24.0);

    final effectiveIconColor = iconColor ?? AppMyColor.lightLavenderPinkColor;

    return Container(
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E2023), Color(0xFF111317)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00D2FF).withValues(alpha: 0.1),
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
                  color: AppMyColor.lightLavenderPinkColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.query_stats,
                  color: effectiveIconColor,
                  size: 28 * scale.clamp(0.9, 1.2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "health_trajectory".tr(),
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 16 * scale.clamp(0.9, 1.15),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle ?? "stability_index_up".tr(),
                      style: TextStyle(
                        fontSize: 12 * scale.clamp(0.9, 1.1),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),

          // Bars
          SizedBox(
            height: barMaxHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: barHeights.map((fraction) {
                final double currentHeight =
                    (barMaxHeight * fraction).clamp(10.0, barMaxHeight);

                return Container(
                  width: barWidth,
                  height: currentHeight,
                  decoration: BoxDecoration(
                    color: fraction >= 0.7
                        ? accentColor
                        : accentColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16 * scale),

          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "stability_status".tr(),
                style: TextStyle(
                  fontSize: 11 * scale.clamp(0.9, 1.1),
                  color: Colors.grey,
                ),
              ),
              Text(
                "weekly_delta".tr(),
                style: TextStyle(
                  fontSize: 11 * scale.clamp(0.9, 1.1),
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}