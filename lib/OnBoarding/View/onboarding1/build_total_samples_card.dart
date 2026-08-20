import 'package:ai_lab/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BuildTotalSamplesCard extends StatelessWidget {
  const BuildTotalSamplesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 680 || size.width < 380;

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6E208C), Color(0xFF1A1C1F)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: isSmallScreen ? -20 : -30,
              bottom: isSmallScreen ? -25 : -35,
              child: Opacity(
                opacity: 0.13,
                child: Icon(
                  Symbols.monitoring,
                  size: isSmallScreen ? 110 : 140,
                  color: const Color(0xFFEDB1FF),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL SAMPLES',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 13,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '1,482',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 48 : 62,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFEDB1FF),
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '+12.4% from yesterday',
                  style: TextStyle(
                    color: AppMyColor.blueColor,
                    fontSize: isSmallScreen ? 14 : 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
