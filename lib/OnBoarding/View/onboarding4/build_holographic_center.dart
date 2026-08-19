import 'package:flutter/material.dart';

class BuildHolographicCenter extends StatelessWidget {
  const BuildHolographicCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return       Stack(
      alignment: Alignment.center,
      children: [
        // Glow
        Container(
          width: 340,
          height: 340,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [const Color(0xFF00D2FF).withValues(alpha:0.25), Colors.transparent],
            ),
          ),
        ),

        // Rotating Rings (بدون animateSpin)
        RotationTransition(
          turns: const AlwaysStoppedAnimation(0.1), // يمكنك إضافة AnimationController لاحقاً
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF00D2FF).withValues(alpha:0.25), width: 1.5),
            ),
          ),
        ),

        RotationTransition(
          turns: const AlwaysStoppedAnimation(-0.08),
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEDB1FF).withValues(alpha:0.3), width: 1),
            ),
          ),
        ),

        // Main Orb
        Container(
          width: 190,
          height: 190,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1A1C1F),
            border: Border.all(color: const Color(0xFF00D2FF), width: 3),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D2FF).withValues(alpha: 0.5),
                blurRadius: 50,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.monitor_heart,
              size: 92,
              color: Color(0xFF00D2FF),
            ),
          ),
        ),
      ],
    );

  }
}
