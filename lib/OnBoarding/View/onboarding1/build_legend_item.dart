import 'package:ai_lab/core/constant/app_size.dart';
import 'package:flutter/material.dart';

class BuildLegendItem extends StatelessWidget {
  const BuildLegendItem({
    super.key,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    return Row(
      children: [
        Container(
          width: 11 * scale,
          height: 11 * scale,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3 * scale),
          ),
        ),
        SizedBox(width: 4 * scale),
        Text(
          label,
          style: TextStyle(
            fontSize: 11 * scale,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}