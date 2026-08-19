import 'package:flutter/material.dart';

class BuildMetricChart extends StatelessWidget {
  const BuildMetricChart({super.key, required this.title, required this.value, required this.unit, required this.color, required this.heights});

  final String title;
  final String value;
  final String unit;
  final Color color;
  final List<int> heights;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + Value
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style:  TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color
                    ),
                  ),
                  TextSpan(
                    text: ' $unit',
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Bar Chart
        SizedBox(
          height: 72,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: heights.asMap().entries.map((entry) {
              final index = entry.key;
              final height = entry.value;
              final isMax = height == heights.reduce((a, b) => a > b ? a : b);

              return Container(
                width: 22,
                height: height * 4.2, // يمكنك تعديل الـ multiplier
                decoration: BoxDecoration(
                  color: isMax ? color : color.withValues(alpha:0.35),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  boxShadow: isMax
                      ? [
                    BoxShadow(
                      color: color.withValues(alpha:0.6),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ]
                      : null,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
