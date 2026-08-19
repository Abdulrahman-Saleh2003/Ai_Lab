import 'package:ai_lab/OnBoarding/View/widget.dart';
import 'package:flutter/material.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSkip;

  const OnboardingAppBar({super.key, required this.onSkip});
  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            const Icon(
              Icons.science,
              color: Color(0xFF00D2FF),
              size: 28,
            ),
            const SizedBox(width: 10),
            const Text(
              'LAB_SYS v1.0',
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Color(0xFF00D2FF),
                fontSize: 16,
                overflow: TextOverflow.ellipsis
                  ,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: onSkip,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF00D2FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha:0.8),
                  width: 1.5,
                ),
              ),
              child: const Text(
                'SKIP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}