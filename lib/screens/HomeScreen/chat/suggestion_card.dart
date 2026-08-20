import 'package:ai_lab/models/home/Chat/message.dart';
import 'package:flutter/material.dart';

class SuggestionCard extends StatelessWidget {
  final Suggestion suggestion;

  const SuggestionCard({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF333538),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF3C494E).withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1C1F),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.bloodtype, size: 18, color: Color(0xFFA5E7FF)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestion.title,
                    style: const TextStyle(
                      color: Color(0xFFE2E2E6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    suggestion.subtitle,
                    style: const TextStyle(
                      color: Color(0xFFBBC9CF),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_back, size: 16, color: Color(0xFFBBC9CF)),
            ],
          ),
        ),
      ),
    );
  }
}