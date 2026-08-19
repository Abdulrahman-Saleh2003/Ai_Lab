import 'package:flutter/material.dart';

class BuildFeatureItem extends StatelessWidget {
  const BuildFeatureItem({super.key, required this.icon, required this.title, required this.desc});

  final IconData icon;
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF00D2FF).withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF00D2FF), size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(
                    color: Color(0xFF00D2FF) ,
                    fontSize: 18, fontWeight: FontWeight.bold),),
                const SizedBox(height: 8),
                Text(desc, style: const TextStyle(color: Colors.grey, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
