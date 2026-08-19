import 'package:flutter/material.dart';

class BuildAlertItem extends StatelessWidget {
  const BuildAlertItem({
    super.key,
    required this.text,
    required this.isCritical,
  });

  final String text;
  final bool isCritical;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return Container(
      padding: EdgeInsets.all(14 * scale),
      decoration: BoxDecoration(
        color: isCritical
            ? const Color(0xFF3A1F1F)
            : const Color(0xFF1F2A1F),
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      child: Row(
        children: [
          Icon(
            isCritical ? Icons.warning_amber : Icons.check_circle,
            color: isCritical ? Colors.red : Colors.green,
            size: 20 * scale,
          ),

          SizedBox(width: 12 * scale),

          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14 * scale,
              ),
            ),
          ),
        ],
      ),
    );
  }
}