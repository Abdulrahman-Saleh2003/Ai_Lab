import 'package:ai_lab/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class BottomHint extends StatelessWidget {
  final String text;

  const BottomHint({
    super.key,
    this.text = 'SECURE LINK ESTABLISHED • v4.0.21-alpha',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        color: AppMyColor.greyApp,
        letterSpacing: 2,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}