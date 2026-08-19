
import 'package:flutter/material.dart';



class BuildActionButtons extends StatelessWidget {
  const BuildActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          // color: Colors.white,
          color: const Color(0xFF00D2FF),

          border: Border.all(color: Colors.white24, width: 1.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Text(
          'WATCH DEMO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
