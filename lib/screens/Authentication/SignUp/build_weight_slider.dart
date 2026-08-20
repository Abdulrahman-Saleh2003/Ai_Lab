import 'package:ai_lab/core/constant/app_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WeightSlider extends StatelessWidget {
  final double weight;
  final Function(double) onChanged;

  const WeightSlider({
    super.key,
    required this.weight,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "biological_weight".tr(),
          style: TextStyle(
            fontSize: 12 * scale,
            color: Colors.white,
            letterSpacing: 1 * scale,
          ),
        ),
        SizedBox(height: 12 * scale),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: weight,
                min: 30,
                max: 300,
                activeColor: const Color(0xFF00D2FF),
                inactiveColor: Colors.grey.withValues(alpha: 0.3),
                onChanged: onChanged,
              ),
            ),
            SizedBox(width: 12 * scale),
            Container(
              width: 70 * scale,
              padding: EdgeInsets.symmetric(
                vertical: 8 * scale,
                horizontal: 12 * scale,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2023),
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Text(
                "${weight.toStringAsFixed(1)} kg",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00D2FF),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}