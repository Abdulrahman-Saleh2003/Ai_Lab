import 'package:flutter/material.dart';

class MiniBar extends StatelessWidget {
  final double height;
  final bool isHighlighted;

  const MiniBar({required this.height, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: height,
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xFF00D2FF) : const Color(0xFF00D2FF).withOpacity(0.4),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
      ),
    );
  }
}

