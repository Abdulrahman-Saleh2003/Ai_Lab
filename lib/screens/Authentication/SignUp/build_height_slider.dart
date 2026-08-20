import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HeightSlider extends StatelessWidget {
  final double height; // بالـ cm
  final ValueChanged<double> onChanged;

  const HeightSlider({
    super.key,
    required this.height,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final meters = (height / 100).toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'height'.tr(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$meters m  (${height.toStringAsFixed(0)} cm)',
              style: const TextStyle(
                color: Color(0xFF00D2FF),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFF00D2FF),
            inactiveTrackColor: Colors.white12,
            thumbColor: const Color(0xFF00D2FF),
            overlayColor: const Color(0xFF00D2FF).withValues(alpha: 0.2),
          ),
          child: Slider(
            value: height,
            min: 150,
            max: 225,
            divisions: 75,
            label: '$meters m',
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
