import 'package:ai_lab/core/constant/app_color.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:flutter/material.dart';

class BuildJourneyStep extends StatelessWidget {
  const BuildJourneyStep({
    super.key,
    required this.icon,
    required this.title,
    required this.time,
    required this.isCompleted,
    this.isActive = false,
  });

  final IconData icon;
  final String title;
  final String time;
  final bool isCompleted;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = AppSize.scale(context);

    final color = isActive
        ? AppMyColor.blueColor
        : isCompleted
            ? AppMyColor.whiteApp
            : Colors.grey;

    return Column(
      children: [
        Container(
          width: size.width / 6,
          height: size.height / 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? AppMyColor.blueColor.withValues(alpha: 0.2)
                : Colors.transparent,
            border: Border.all(
              color: color,
              width: isActive ? 3 * scale : 2 * scale,
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: 28 * scale,
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14 * scale,
            color: isActive ? AppMyColor.blueColor : color,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 10 * scale,
            color: isActive ? AppMyColor.blueColor : AppMyColor.greyApp,
          ),
        ),
      ],
    );
  }
}