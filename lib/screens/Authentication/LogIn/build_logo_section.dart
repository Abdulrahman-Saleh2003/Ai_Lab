import 'package:flutter/material.dart';
import 'package:ai_lab/core/constant/app_color.dart';
import 'package:ai_lab/core/constant/app_size.dart';

class BuildLogoSection extends StatelessWidget {
  const BuildLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    return Column(
      children: [
        Container(
          width: 100 * scale,
          height: 100 * scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1A1C1F),
            border: Border.all(
              color: AppMyColor.blueColor.withValues(alpha: 0.3),
              width: 2 * scale,
            ),
            boxShadow: [
              BoxShadow(
                color: AppMyColor.blueColor.withValues(alpha: 0.3),
                blurRadius: 30 * scale,
                spreadRadius: 5 * scale,
              ),
            ],
          ),
          child: Icon(
            Icons.science,
            size: 55 * scale,
            color: AppMyColor.blueColor,
          ),
        ),

        SizedBox(height: 16 * scale),

        Text(
          'LABSYNC',
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 32 * scale,
            fontWeight: FontWeight.bold,
            color: AppMyColor.blueColor,
            letterSpacing: 4 * scale,
          ),
        ),

        Text(
          'SYNTHETIC ALCHEMY PROTOCOL',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 11 * scale,
            letterSpacing: 3 * scale,
            color: AppMyColor.greyApp,
          ),
        ),
      ],
    );
  }
}